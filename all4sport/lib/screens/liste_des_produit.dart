import 'dart:convert';

import 'package:flutter/material.dart';

class ListeProduit extends StatefulWidget {
  const ListeProduit({super.key});

  @override
  State<ListeProduit> createState() => _ListeProduitState();
}

class _ListeProduitState extends State<ListeProduit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All4Sport - Liste Produit",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      ),
      body: const Column(
        children: [
          Card(
            child: ListTile(
              title: Text("Produit 1"),
              subtitle: Text("Test"),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Produit 2"),
              subtitle: Text("Test"),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Produit 3"),
              subtitle: Text("Test"),
            ),
          ),
        ],
      ),
    );
  }
}
