import 'package:expenses_test/components/expense_ball.dart';
import 'package:expenses_test/theme/colors.dart';
import 'package:flutter/material.dart';
import '../bloc/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: Text('Expenses overview', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: StreamBuilder(
            stream: bloc.getTotalExpensesByCategory,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xff799F0C)),
                  ),
                );
              }
              return Center(
                child: Wrap(
                  children: snapshot.data.map<Widget>((data) {
                    return ExpenseBall(data: data);
                  }).toList(),
                ),
              );

            },
          ),
        ));
  }
}
