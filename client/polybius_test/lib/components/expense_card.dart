import 'package:flutter/material.dart';
import 'package:polybius_test/components/expense_card_item.dart';
import 'package:polybius_test/models/expense_model.dart';
import 'package:polybius_test/theme/colors.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    Key key,
    @required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topCenter,
              colors: gradientColors
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 8.0),
                Text(
                  data['dateFormated'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
                SizedBox(height: 8.0),
                Column(
                  children: data['data'].map<Widget>((Expense x) {
                    return new ExpenseCardItem(data: x,);
                  }).toList(),
                )
              ],
            ),
          ),
        ));
  }
}

