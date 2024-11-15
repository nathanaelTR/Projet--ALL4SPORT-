import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({super.key});

  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  late MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(); // Initialise le contrôleur
    controller.start(); // Démarre la caméra
  }

  @override
  void dispose() {
    controller.dispose(); // Arrête et libère les ressources de la caméra
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanner QR Code"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Caméra en plein écran
          MobileScanner(
            controller: controller,
            onDetect: (BarcodeCapture capture) {
              final List<Barcode> barcodes = capture.barcodes;

              for (final barcode in barcodes) {
                print("Code QR détecté : ${barcode.rawValue}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QRCodeResultScreen(result: barcode.rawValue ?? ''),
                  ),
                );
              }
            },
          ),

          // Superposition pour afficher le résultat du code QR scanné
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QRCodeResultScreen extends StatelessWidget {
  final String result;

  const QRCodeResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Résultat du QR Code"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: result,
              version: QrVersions.auto,
              size: 200.0,
            ),
            const SizedBox(height: 20.0),
            Text(
              result,
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
