import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatBotAPI {
  static const String _baseUrl =
      'https://api.gemini.com'; // Modifica con l'endpoint reale

  // Funzione per inviare una domanda al bot
  static Future<String> getBotResponse(String question) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/chat'), // Modifica con l'endpoint appropriato
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_API_KEY', // Aggiungi la tua chiave API
      },
      body: json.encode({'question': question}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['response']; // Modifica in base alla risposta dell'API
    } else {
      throw Exception('Failed to get response from bot');
    }
  }
}
