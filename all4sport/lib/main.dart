import 'package:all4sport/screens/connexion.dart';
import 'package:flutter/material.dart';

void main() {
  debugPrint('Main function called');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    debugPrint('MainApp build method called');
    return const MaterialApp(
      home: ConnectScreen(),
    );
  }
}
