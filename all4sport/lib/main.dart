
import 'package:flutter/material.dart';
import 'package:all4sport/screens/connexion.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ConnectScreen(),
    );

    
  }
}

