import 'dart:async';
import 'dart:convert';
import 'package:polybius_test/models/expense_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class Bloc {

  // Initalizing controllers
  final _totalExpensesController = BehaviorSubject<List>();
  final _totalSumController = BehaviorSubject<double>();
  final _getByDateController = BehaviorSubject<List>();


  // streams to output data
  get getTotalExpensesByCategory => _totalExpensesController.stream;
  get getbyDate => _getByDateController.stream;
  get totalSum => _totalSumController.stream;


  // Constructor for getting initial data
  Bloc() {
    fetchDataFromApi().then((ExpensesList expesesList) {
      getCategorys();
      calculateTotalExpenses();
    });
  }


  ExpensesList allExpenses;
  List categorys = [];
  List totalExpensesByCategory = [];
  double totalAmount = 0.0;

  Future<ExpensesList> fetchDataFromApi() async {
    var url = 'http://10.0.2.2:3000';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      allExpenses = ExpensesList.fromJson(json.decode(response.body));
      return null;
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  // get all different category's from data
  getCategorys() {
    allExpenses.expenses.forEach((x) {
      if (!categorys.contains(x.category)) {
        categorys.add(x.category);
      }
    });
  }


  // calculate total expenses amount & total expenses amount by category and add it to stream
  calculateTotalExpenses() {
    categorys.forEach((category) {
      double total = 0.0;
      List<Expense> sortedByCategory = allExpenses.expenses.where((x) => x.category == category).toList();
      sortedByCategory.forEach((Expense x) => total += double.parse(x.amount));
      totalExpensesByCategory.add({
        'category': category,
        'total': total.toStringAsFixed(2),
      });
    });
    totalExpensesByCategory.forEach((x) => totalAmount += double.parse(x['total']));
    
    // adding data to the streams
    _totalExpensesController.sink.add(totalExpensesByCategory);
    _totalSumController.sink.add(totalAmount);
  }


  getExpensesByCategory(selectedCategory) {

    List<Expense> sortedByCategory;
    List<String> dates = [];
    List<Map> sortedByDate = [];


     // filter expenses by category
    sortedByCategory = allExpenses.expenses
        .where((Expense x) => x.category == selectedCategory)
        .toList();


    // check if there is expenses in same day
    sortedByCategory.forEach((Expense x) {

      // formating date to dd/mm/yyyy
      DateTime now = DateTime.parse(x.transactionTime);
      String date = DateFormat('dd/MM/yyyy').format(now);
      
      if (!dates.contains(date)) {
        dates.add(date);
        sortedByDate.add({
          'dateFormated': date,
          'date': x.transactionTime,
          'data': [x],
        });
      } else {
        sortedByDate.forEach((Map f) {
          if (f['dateFormated'] == date) {
            f['data'].add(x);
          }
        });
      }
    });

     // sort expenses by date
    sortedByDate.sort((a, b) => b['date'].compareTo(a['date']));

     // add data to date controller stream.
    _getByDateController.sink.add(sortedByDate);
  }


  // close streams
  dispose() {
    _totalExpensesController.close();
    _totalSumController.close();
    _getByDateController.close();
  }
}
