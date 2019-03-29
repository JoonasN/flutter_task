import 'package:expenses_test/bloc/provider.dart';
import 'package:expenses_test/components/expense_card.dart';
import 'package:expenses_test/theme/colors.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final data;
  DetailsScreen(this.data);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    bloc.getExpensesByCategory(data['category']);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Expenses details for ${data["category"]}'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 8.0),
        color: bgColor,
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder(
          stream: bloc.getbyDate,
          builder: (context, snapshot) {
            
            if (snapshot.data == null) {
              return Container();
            }
            return Container(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[index];
                    return new ExpenseCard(data: data);
                  }),
            );
            
          },
        ),
      ),
    );
  }
}
