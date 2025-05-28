import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ChatBotService {
  static const String _chatHistoryKey = 'chat_history';

  final Map<String, Function(String)> _intentHandlers = {
    'news': _handleNewsIntent,
    'complaint': _handleComplaintIntent,
    'location': _handleLocationIntent,
    'help': _handleHelpIntent,
    'greeting': _handleGreetingIntent,
  };

  static String _handleNewsIntent(String message) {
    if (message.contains('latest')) {
      return "I'll fetch the latest news from Lyari for you. Would you like to specify any particular category?";
    }
    return "I can help you find news about Lyari. Are you interested in any specific topic?";
  }

  static String _handleComplaintIntent(String message) {
    if (message.contains('status')) {
      return "I can help you check the status of your complaint. Please provide your complaint reference number.";
    }
    return "I can assist you with filing a complaint. Would you like to proceed with filing a new complaint?";
  }

  static String _handleLocationIntent(String message) {
    return "I can help you find locations in Lyari. What type of service are you looking for? (e.g., Healthcare, Education, Sports)";
  }

  static String _handleHelpIntent(String message) {
    return """I can help you with:
1. Finding local news
2. Filing and tracking complaints
3. Locating services in Lyari
4. Updating your profile
What would you like assistance with?""";
  }

  static String _handleGreetingIntent(String message) {
    return "Hello! I'm your Lyari Town assistant. How can I help you today?";
  }

  String _detectIntent(String message) {
    message = message.toLowerCase();

    if (message.contains('news') ||
        message.contains('update') ||
        message.contains('latest')) {
      return 'news';
    }
    if (message.contains('complaint') ||
        message.contains('problem') ||
        message.contains('issue')) {
      return 'complaint';
    }
    if (message.contains('where') ||
        message.contains('location') ||
        message.contains('find')) {
      return 'location';
    }
    if (message.contains('help') ||
        message.contains('assist') ||
        message.contains('support')) {
      return 'help';
    }
    if (message.contains('hi') ||
        message.contains('hello') ||
        message.contains('hey')) {
      return 'greeting';
    }

    return 'unknown';
  }

  String generateResponse(String message) {
    final intent = _detectIntent(message);
    final handler = _intentHandlers[intent];

    if (handler != null) {
      return handler(message);
    }

    return "I'm not sure how to help with that specific request. Would you like to know what I can assist you with?";
  }

  Future<void> saveMessage(Map<String, String> message) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final history = prefs.getStringList(_chatHistoryKey) ?? [];
      history.add(json.encode(message));
      await prefs.setStringList(_chatHistoryKey, history);
    } catch (e) {
      print('Error saving message: $e');
    }
  }

  Future<List<Map<String, String>>> getChatHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final history = prefs.getStringList(_chatHistoryKey) ?? [];
      return history
          .map((message) => Map<String, String>.from(json.decode(message)))
          .toList();
    } catch (e) {
      print('Error retrieving chat history: $e');
      return [];
    }
  }
}
