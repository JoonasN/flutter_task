import 'package:flutter/material.dart';
import 'package:polybius_test/bloc/provider.dart';
import 'package:polybius_test/screens/details_screen.dart';
import 'package:polybius_test/theme/colors.dart';

class ExpenseBall extends StatelessWidget {
  final data;

  calculateSize(categoryTotal, snapshot) => categoryTotal > 7000 ?  (categoryTotal / snapshot.data) * 600 : (7000 / snapshot.data) * 600;

  calculateFontSize(categoryTotal, size) {
    if(categoryTotal > 7000 && categoryTotal < 20000) {
       return  categoryTotal / size;
    }
    if(categoryTotal < 7000) {
      return 7000 / size;
    }
    if(categoryTotal > 20000) {
      return 20000 / size;
    }
  }
  const ExpenseBall({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: StreamBuilder(
        stream: bloc.totalSum,
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return Container();
          }

          var categoryTotal = double.parse(data['total']);

          return Container(
            height: calculateSize(categoryTotal, snapshot),
            width: calculateSize(categoryTotal, snapshot),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColors),
              shape: BoxShape.circle,
            ),
            child: Material(
              elevation: 2.0,
              color: Colors.transparent,
              shape: CircleBorder(),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsScreen(data)));
                },
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${data['category']}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: calculateFontSize(categoryTotal, 500)),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '\$ ${data['total']}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: calculateFontSize(categoryTotal, 800)),
                        )
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
