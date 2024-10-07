import 'package:flutter/material.dart';
import 'dart:convert'; 
import 'package:flutter/services.dart'; 
import 'package:all4sport/screens/accueil.dart'; 

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String errorMessage = '';

  // Fonction pour lire et vérifier les identifiants à partir du fichier JSON
  Future<bool> _validateCredentials(String login, String password) async {
    // Charger le fichier JSON
    String jsonData = await rootBundle.loadString('assets/json/login.json');
    Map<String, dynamic> data = json.decode(jsonData);

    // Parcourir les comptes pour trouver une correspondance
    for (var account in data['compte']) {
      if (account['login'] == login && account['password'] == password) {
        // Vérifier si l'utilisateur a le rôle de "carriste"
        if (account['role'] == 'carriste') {
          return true; // Identifiants valides et rôle correct
        } else {
          setState(() {
            errorMessage = 'Seuls les carristes peuvent se connecter.';
          });
          return false; // Rôle incorrect
        }
      }
    }
    return false; // Identifiants incorrects
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Se connecter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(labelText: 'Login'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Vérification des identifiants avec le fichier JSON
                bool isValid = await _validateCredentials(
                  _loginController.text,
                  _passwordController.text,
                );

                if (isValid) {
                  // Rediriger vers la page d'accueil si les identifiants et le rôle sont corrects
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Accueil()),
                  );
                } else {
                  // Afficher un message d'erreur si les identifiants sont incorrects ou si le rôle ne correspond pas
                  setState(() {
                    errorMessage = 'Login, mot de passe ou rôle incorrect';
                  });
                }
              },
              child: const Text('Se connecter'),
            ),
            const SizedBox(height: 20),
            // Affichage du message d'erreur
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
