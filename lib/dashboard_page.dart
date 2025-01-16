import 'package:flutter/material.dart';
import 'counter_widget.dart';
import 'chat_bot_page.dart'; // Aggiungi l'import per la ChatBotPage

class DashboardPage extends StatelessWidget {
  final String? name;
  final String? email;

  const DashboardPage({super.key, this.name, this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: CounterWidget(),
          ),
          Divider(color: Colors.grey.shade700),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome, ${name ?? 'User'}!',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email: ${email ?? 'Not Provided'}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20),
                  // Pulsante per navigare alla ChatBotPage
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatBotPage()),
                      );
                    },
                    child: const Text('Go to Chatbot'),
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
