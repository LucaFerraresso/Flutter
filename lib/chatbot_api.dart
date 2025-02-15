import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatBotAPI {
  static Future<String> sendMessage(String message) async {
    final String? baseUrl = dotenv.env['BASE_URL'];
    final String? apiKey = dotenv.env['API_KEY'];

    if (baseUrl == null || apiKey == null) {
      throw Exception('Variabili di ambiente mancanti: BASE_URL o API_KEY');
    }

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'message': message}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['response'];
    } else {
      throw Exception('Failed to get response from bot');
    }
  }
}
