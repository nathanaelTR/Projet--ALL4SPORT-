import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ArrivageScreen extends StatefulWidget {
  const ArrivageScreen({super.key});

  @override
  _ArrivageScreenState createState() => _ArrivageScreenState();
}

class _ArrivageScreenState extends State<ArrivageScreen> {
  final _formKey = GlobalKey<FormState>();
  String _productReference = '';
  String _warehouse = '';
  int _quantity = 0;
  bool isLoading = false;
  bool isWarehouseDetected = false;
  bool isLocationFailed = false;

  String? _productInfo;
  final TextEditingController _warehouseController = TextEditingController();

  final List<Map<String, dynamic>> warehouses = [
    {'name': 'Valenciennes', 'latitude': 50.35, 'longitude': 3.52},
    {'name': 'Lille', 'latitude': 50.63, 'longitude': 3.05},
    {'name': 'Nice', 'latitude': 43.70, 'longitude': 7.26}
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationError();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showLocationError();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showLocationError();
      return;
    }

    final LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
    );

    try {
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
      _checkNearestWarehouse(position.latitude, position.longitude);
    } catch (e) {
      print("Erreur lors de la récupération de la localisation: $e");
      _showLocationError();
    }
  }

  void _checkNearestWarehouse(double userLatitude, double userLongitude) {
    const double tolerance = 0.05;
    String detectedWarehouse =
        'Saisir un Entrepôt (Aucun Entrepot n\'est référencer dans cette ville)';

    for (var warehouse in warehouses) {
      double latDiff = (userLatitude - warehouse['latitude']).abs();
      double lonDiff = (userLongitude - warehouse['longitude']).abs();
      print(latDiff < tolerance && lonDiff < tolerance);
      if (latDiff < tolerance && lonDiff < tolerance) {
        detectedWarehouse = warehouse['name'];
        isWarehouseDetected = true;
        break;
      }
    }

    setState(() {
      _warehouse = detectedWarehouse;
      _warehouseController.text =
          detectedWarehouse; // Mettez à jour le contrôleur
      isLoading = false;
      isLocationFailed = !isWarehouseDetected;
    });

    if (!isWarehouseDetected) {
      _showLocationError();
    }
  }

  void _showLocationError() {
    setState(() {
      isLoading = false;
      isLocationFailed = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
            'Géolocalisation échouée ou lieu non détecté. Veuillez entrer manuellement l\'entrepôt.',
            style: TextStyle(fontSize: 25)),
        duration: const Duration(days: 1),
        action: SnackBarAction(label: "X", onPressed: () {}),
      ),
    );
  }

  @override
  void dispose() {
    _warehouseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arrivage de Stock'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Référence ALL4SPORT'),
                onSaved: (value) {
                  _productReference = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la référence du produit';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Entrepôt'),
                controller: _warehouseController,
                onSaved: (value) {
                  _warehouse = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer l\'entrepôt';
                  }
                  return null;
                },
                readOnly: !isLocationFailed && isWarehouseDetected,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Quantité'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _quantity = int.parse(value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la quantité';
                  }
                  final quantity = int.tryParse(value);
                  if (quantity == null || quantity <= 0) {
                    return 'Veuillez entrer un nombre valide et positif';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    var productData = {
                      'ref': _productReference,
                      'entrepot': _warehouse,
                      'quantité': _quantity,
                    };
                    setState(() {
                      _productInfo = jsonEncode(productData);
                    });
                    print(jsonEncode(productData));
                  }
                },
                child: const Text('Ajouter le nouveau produit'),
              ),
              if (isLoading) const CircularProgressIndicator(),
              if (_productInfo != null) ...[
                const SizedBox(height: 20),
                Text(
                  'Données du produit : $_productInfo',
                  style: const TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
