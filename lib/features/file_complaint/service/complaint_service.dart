import 'dart:convert';
import 'package:http/http.dart' as http;

class ComplaintService {
  static const String baseUrl = 'http://localhost:4000';

  static Future<bool> submitComplaint({
    required int userId,
    required String description,
    required String cnic,
    required String priority,
    required String createdBy,
    required String email,
  }) async {
    final url = Uri.parse('$baseUrl/complaints');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'complaint_description': description,
        'cnic_number': cnic,
        'priority': priority.toLowerCase(),
        'created_by': createdBy,
        'author_email': email,
      }),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
