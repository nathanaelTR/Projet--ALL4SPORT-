import 'package:all4sport/qrcode/qrcode.dart';
import 'package:all4sport/screens/arrivage.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ArrivageScreen(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bienvenue sur le scanner de QR code'),
            ElevatedButton(
              child: const Text('Clique pour scanner un QRcode'),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => QrCodeScanner(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}