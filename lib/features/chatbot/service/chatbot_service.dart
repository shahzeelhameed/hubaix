import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatBotService {
  static const String _chatHistoryKey = 'chat_history';
  static const String _apiUrl = 'http://localhost:8000/ask-question/';

  Future<String> generateResponse(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'question': message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] ?? 'No response received.';
      } else {
        print('HTTP error ${response.statusCode}: ${response.body}');
        return 'Server error occurred.';
      }
    } catch (e) {
      print('Exception: $e');
      return 'Failed to connect to chatbot API.';
    }
  }

  Future<void> saveMessage(Map<String, String> message) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_chatHistoryKey) ?? [];
    history.add(jsonEncode(message));
    await prefs.setStringList(_chatHistoryKey, history);
  }

  Future<List<Map<String, String>>> getChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_chatHistoryKey) ?? [];
    return history.map((e) => Map<String, String>.from(jsonDecode(e))).toList();
  }
}
