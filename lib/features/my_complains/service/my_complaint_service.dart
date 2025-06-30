// lib/features/my_complains/service/complaint_fetch_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hubaix/constant/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/model/complaint.dart';

class ComplaintFetchService {
  static Future<List<Complaint>> getUserComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    print('User ID: $userId');
    if (userId == 0) {
      throw Exception('User ID not found in shared preferences');
    }
    final response = await http.get(Uri.parse('$baseUrl/getComplaint/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Complaint.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  static Future<bool> deleteComplaint(int complaintId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete-complaint/$complaintId'),
    );

    return response.statusCode == 200;
  }
}
