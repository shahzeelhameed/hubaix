import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hubaix/constant/base_url.dart';

class ComplaintService {
  static Future<bool> submitComplaint({
    required int userId,
    required String description,
    required String cnic,
    required String priority,
    required String createdBy,
    required String email,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/api/create-complaint');

      final body = {
        'user_id': userId,
        'complaint_description': description,
        'cnic_number': cnic,
        'priority': priority.toLowerCase(),
        'created_by': createdBy,
        'author_email': email,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      print('Status: ${response.statusCode}');
      print('Response: ${response.body}');

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Error submitting complaint: $e');
      return false;
    }
  }
}
