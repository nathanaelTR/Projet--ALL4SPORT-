import 'package:flutter/material.dart';
import 'package:all4sport/screens/accueil.dart'; // Import de la page Accueil

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Identifiants en dur (login et mot de passe)
  final String correctLogin = 'admin';
  final String correctPassword = 'password123';

  String errorMessage = '';

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
              onPressed: () {
                // Vérifier les identifiants
                if (_loginController.text == correctLogin &&
                    _passwordController.text == correctPassword) {
                  // Rediriger vers la page d'accueil si les identifiants sont corrects
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Accueil()),
                  );
                } else {
                  // Afficher un message d'erreur si les identifiants sont incorrects
                  setState(() {
                    errorMessage = 'Login ou mot de passe incorrect';
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