
import 'package:all4sport/screens/accueil.dart';
import 'package:all4sport/screens/arrivage.dart';
import 'package:all4sport/screens/connexion.dart';
import 'package:all4sport/screens/liste_des_produit.dart';
import 'package:flutter/material.dart';

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
