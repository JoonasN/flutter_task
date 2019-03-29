import 'package:flutter/material.dart';

class ExpenseCardItem extends StatelessWidget {
  final data;
  const ExpenseCardItem({
    Key key,
    this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white.withOpacity(0.7),
        child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  data.description,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      data.currency,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      data.amount,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
