import 'package:flutter/material.dart';
import '../db/database_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final dbHelper = DatabaseHelper.instance;

  Future<void> _registerUser() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (await dbHelper.emailExists(email)) {
      _showMessage('Cet email est déjà utilisé.');
      return;
    }

    await dbHelper.insertUser({
      'name': name,
      'email': email,
      'password': password,
    });

    _showMessage('Inscription réussie !');
    Navigator.pop(context); // retour à l'écran de bienvenue
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("S'inscrire")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) => value!.isEmpty ? 'Entrez votre nom' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Entrez votre email' : null,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                validator: (value) => value!.length < 6 ? 'Au moins 6 caractères' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _registerUser();
                  }
                },
                child: const Text("S'inscrire"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
