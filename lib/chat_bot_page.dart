import 'package:flutter/material.dart';
import 'chatbot_api.dart'; // Importa la classe che gestisce le API

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key}); // Utilizza super.key come super parameter

  @override
  ChatBotPageState createState() => ChatBotPageState();
}

class ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';

  void _sendMessage() async {
    final question = _controller.text;
    if (question.isNotEmpty) {
      setState(() {
        _response = 'Thinking...'; // Visualizza il messaggio durante l'attesa
      });

      try {
        // Usa il metodo `sendMessage` definito in `ChatBotAPI`
        final response = await ChatBotAPI.sendMessage(question);
        setState(() {
          _response = response; // Visualizza la risposta del bot
        });
      } catch (e) {
        setState(() {
          _response =
              'Sorry, I couldn\'t understand that.'; // Gestione degli errori
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with AI'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Ask me anything...'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _sendMessage,
              child: const Text('Send'),
            ),
            const SizedBox(height: 20),
            Text(
              _response,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
