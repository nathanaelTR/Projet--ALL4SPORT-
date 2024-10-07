import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show rootBundle; // Pour charger les fichiers JSON

class ListeProduit extends StatefulWidget {
  const ListeProduit({super.key});

  @override
  State<ListeProduit> createState() => _ListeProduitState();
}

class _ListeProduitState extends State<ListeProduit> {
  List<dynamic> jsonProduit = [];

  // Fonction pour charger le fichier JSON depuis les assets
  Future<void> loadJsonData() async {
    try {
      // Charger le fichier JSON
      String jsonString =
          await rootBundle.loadString('assets/json/listeproduit.json');
      // Décoder le JSON et stocker la liste de produits
      setState(() {
        jsonProduit = jsonDecode(jsonString)['produits'];
      });
    } catch (error) {
      print("Erreur lors du chargement du fichier JSON : $error");
    }
  }

  @override
  void initState() {
    super.initState();
    // Charger les données JSON lors de l'initialisation de l'état
    loadJsonData();
  }

  // Vue de Carte de Produit
  Widget produitCard(String title, String subtitle) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }

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
      // Utilisation de ListView pour éviter des problèmes d'affichage
      body: jsonProduit.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: jsonProduit.length,
              itemBuilder: (context, index) {
                var produit = jsonProduit[index];
                return produitCard(
                  '${produit["nom_de_produit"]} ', // Affiche la référence du produit
                  'Ref: ${produit['ref_produit']}\nQuantité: ${produit["quantite"]}', // Affiche le nom du produit
                );
              },
            ),
          
    );
  }
}
