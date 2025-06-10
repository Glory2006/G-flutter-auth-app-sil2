import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  // Constructeur avec paramètre key optionnel
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenue dans l\'application',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action du bouton
              },
              child: const Text('Commencer'),
            ),
          ],
        ),
      ),
    );
  }
}