import 'package:flutter/material.dart';
import '../db/database_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final dbHelper = DatabaseHelper.instance;

  Future<void> _loginUser() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final user = await dbHelper.getUserByEmailAndPassword(email, password);

    if (user != null) {
      _showMessage('Connexion réussie. Bienvenue ${user['name']} !');
      Navigator.pop(context); // Retour à l'écran d'accueil
    } else {
      _showMessage('Identifiants incorrects.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Entrez votre email' : null,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                validator: (value) => value!.isEmpty ? 'Entrez votre mot de passe' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _loginUser();
                  }
                },
                child: const Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
