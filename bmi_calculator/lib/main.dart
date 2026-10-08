import 'package:flutter/material.dart';
import 'constants.dart';
import 'screens/input_page.dart';

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kBackgroundColour,
        appBarTheme: const AppBarTheme(backgroundColor: kBackgroundColour),
      ),
      home: const InputPage(),
    );
  }
}