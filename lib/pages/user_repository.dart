import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  final String baseUrl;

  UserRepository({this.baseUrl = 'http://localhost:4000'});

  Future<void> updateUserProfileById(int userId, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/users/$userId');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile: ${response.statusCode} - ${response.body}');
    }
  }
}
