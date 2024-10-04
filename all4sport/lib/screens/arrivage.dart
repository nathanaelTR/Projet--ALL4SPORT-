import 'package:flutter/material.dart';

class ArrivageScreen extends StatefulWidget {
  const ArrivageScreen({Key? key}) : super(key: key);
  @override
  _ArrivageScreenState createState() => _ArrivageScreenState();
}

class _ArrivageScreenState extends State<ArrivageScreen> {
  static const IconData qr_code_2 = IconData(0xe4f6, fontFamily: 'MaterialIcons');
  final _formKey = GlobalKey<FormState>();
  String _productReference = '';
  String _warehouse = '';
  int _quantity = 0;
  int index = 0;
  final List<String> customizations = ['Customization1', 'Customization2']; // Example list

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
                decoration: const InputDecoration(labelText: 'Référence ALL4SPORT'),
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
                onSaved: (value) {
                  _warehouse = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer l\'entrepôt';
                  }
                  return null;
                },
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
                  if (int.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Ajout du produit
                    print('Référence: $_productReference');
                    print('Entrepôt: $_warehouse');
                    print('Quantité: $_quantity');
                  }
                },
                child: const Text('Ajouter le nouveau produit'),
              ),
              Center(
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      index = (index + 1) % customizations.length;
                    });
                  },
                  child: const Icon(Icons.qr_code_2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}