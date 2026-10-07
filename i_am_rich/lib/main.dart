import 'package:flutter/material.dart';

void main() => runApp(const IAmRich());

class IAmRich extends StatelessWidget {
  const IAmRich({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFFFF8FF),
        appBar: AppBar(
          title: const Text('I Am Rich'),
          backgroundColor: Colors.orange,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/diamond.png', width: 250),
              const SizedBox(height: 16),
              const Icon(Icons.diamond, size: 48, color: Colors.blue),
              const Text(
                'I Am Rich',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}