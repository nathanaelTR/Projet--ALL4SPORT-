import 'package:all4sport/screens/liste_des_produit.dart';
import 'package:flutter/material.dart';
import 'package:all4sport/screens/connexion.dart'; // Import de la page de connexion

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All4Sport",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        // Ajout du bouton retour à droite dans la AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward), // Utiliser une flèche vers l'avant pour l'indication
            onPressed: () {
              // Retour à la page de connexion
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ConnectScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Liste des Produits'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const ListeProduit()));
              },
            ),
            ListTile(
              title: const Text('Panier'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const Stack(children: []),
    );
  }
}
