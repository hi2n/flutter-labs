import 'package:flutter/material.dart';

void main() => runApp(const MiCard());

class MiCard extends StatelessWidget {
  const MiCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFFF5722),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('images/avatar.jpg'),
              ),
              const Text(
                'Pham Thi Thanh Hien', 
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                'FLUTTER DEVELOPER',
                style: TextStyle(
                  color: Colors.orange.shade100,
                  fontSize: 16,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
                width: 150,
                child: Divider(color: Colors.white70),
              ),
              const InfoCard(
                icon: Icons.phone,
                text: '+84 798 115 852', 
              ),
              const InfoCard(
                icon: Icons.email,
                text: 'ptth640@gmail.com', 
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepOrange),
        title: Text(
          text,
          style: const TextStyle(color: Colors.deepOrange),
        ),
      ),
    );
  }
}