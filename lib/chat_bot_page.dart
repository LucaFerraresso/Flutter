import 'package:flutter/material.dart';
import 'chatbot_api.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';

  void _sendMessage() async {
    final question = _controller.text;
    if (question.isNotEmpty) {
      setState(() {
        _response = 'Thinking...';
      });

      try {
        final response = await ChatBotAPI.getBotResponse(question);
        setState(() {
          _response = response;
        });
      } catch (e) {
        setState(() {
          _response = 'Sorry, I couldn\'t understand that.';
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
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
