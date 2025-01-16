// dashboard_page.dart
import 'package:first_android_app_luca/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat_bot_page.dart';

class DashboardPage extends StatelessWidget {
  final String? name;
  final String? email;

  const DashboardPage({super.key, this.name, this.email});

  // Funzione di logout
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // Rimuovi solo lo stato di login, ma non le credenziali salvate
    await prefs.remove('is_logged_in');

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Benvenuto, ${name ?? 'User'}!'),
            subtitle: Text('Email: ${email ?? 'Non fornita'}'),
          ),
          const Divider(),
          ListTile(
            title: const Text('Esercizi'),
            leading: const Icon(Icons.fitness_center),
            onTap: () {
              // Naviga alla sezione Esercizi
            },
          ),
          ListTile(
            title: const Text('Chatbot'),
            leading: const Icon(Icons.chat),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatBotPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Modifica Profilo'),
            leading: const Icon(Icons.person),
            onTap: () {
              // Naviga alla sezione per modificare il profilo
            },
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () => _logout(context),
            style: ElevatedButton.styleFrom(
              iconColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
