// login_page.dart
import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'sign_up_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _logger = Logger();

  @override
  void initState() {
    super.initState();
    _checkSavedCredentials();
  }

  // Controlla se l'utente è già loggato
  Future<void> _checkSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    if (isLoggedIn) {
      final email = prefs.getString('saved_email');
      final password = prefs.getString('saved_password');

      if (email != null && password != null) {
        _logger.i('Utente già loggato: email=$email');

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(name: 'User', email: email),
          ),
        );
      } else {
        _logger.w('Credenziali non trovate, ma stato di login attivo');
      }
    } else {
      _logger.i('Utente non loggato');
    }
  }

  // Funzione per gestire il login
  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email');
    final savedPassword = prefs.getString('saved_password');

    if (savedEmail == null || savedPassword == null) {
      if (!mounted) return;

      _logger
          .w('Credenziali non trovate in SharedPreferences. Reindirizzando...');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationPage()),
      );
    } else if (savedEmail == _emailController.text &&
        savedPassword == _passwordController.text) {
      if (!mounted) return;

      _logger.i('Login riuscito. Reindirizzando alla Dashboard...');
      await prefs.setBool('is_logged_in', true); // Salva lo stato di login

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(name: 'User', email: savedEmail),
        ),
      );
    } else {
      if (!mounted) return;

      _logger.e('Credenziali non valide inserite');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenziali non valide')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                if (!mounted) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationPage(),
                  ),
                );
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
