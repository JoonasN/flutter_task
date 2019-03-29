import 'package:flutter/material.dart';
import 'package:polybius_test/screens/home_screen.dart';
import './bloc/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Expenses',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
