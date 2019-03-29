class Expense {
  final int id;
  final String category;
  final String description;
  final String transactionTime;
  final String amount;
  final String currency;

  Expense(
      {this.id,
      this.category,
      this.description,
      this.transactionTime,
      this.amount,
      this.currency});

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      category: json['category'],
      description: json['description'],
      transactionTime: json['transactionTime'],
      amount: json['amount'],
      currency: json['currency'],
    );
  }
}

class ExpensesList {
  final List<Expense> expenses;

  ExpensesList({
    this.expenses,
  });

  factory ExpensesList.fromJson(List<dynamic> parsedJson) {
    List<Expense> expenses = new List<Expense>();
    expenses = parsedJson.map((i) => Expense.fromJson(i)).toList();
    return new ExpensesList(expenses: expenses);
  }
}
