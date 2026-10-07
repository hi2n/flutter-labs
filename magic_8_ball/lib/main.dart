import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const BallApp());

class BallApp extends StatelessWidget {
  const BallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFFFF8FF),
        appBar: AppBar(
          title: const Text('Ask Me Anything'),
          backgroundColor: Colors.deepPurple.shade200,
        ),
        body: const BallPage(),
      ),
    );
  }
}

class BallPage extends StatefulWidget {
  const BallPage({super.key});

  @override
  State<BallPage> createState() => _BallPageState();
}

class _BallPageState extends State<BallPage> {
  int ballNumber = 1;

  void askAgain() {
    setState(() {
      ballNumber = Random().nextInt(5) + 1; // số từ 1 đến 5
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: askAgain,
            child: Image.asset('assets/ball$ballNumber.png'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: askAgain,
            child: const Text('Nhận câu trả lời'),
          ),
        ],
      ),
    );
  }
}