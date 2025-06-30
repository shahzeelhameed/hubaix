import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hubaix/constant/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bottom_navigation/pages/home_page/repository/model/user_profile_model.dart';

class AuthenticationService {
  Future<bool> signUp({
    required String username,
    required String email,
    required String password,
    required String cnic,
    required String phone,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
          "retypepassword": password,
          "cnic_number": cnic,
          "role": "user",
          "phone": phone,
        }),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Registration error: $e');
      throw Exception('Sign up failed: $e');
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        final user = responseData['user'];

        await _storeUserData(
          token: token,
          userId: user['user_id'],
          username: user['username'],
          email: user['email'],
          cnic: user['cnic_number'],
          phone: user['phone'] ?? '',
          role: user['role'],
        );

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      throw Exception('Login failed: $e');
    }
  }

  Future<void> _storeUserData({
    required String token,
    required int userId,
    required String username,
    required String email,
    required String cnic,
    required String phone,
    required String role,
  }) async {
    print(userId);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setInt('user_id', userId);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('cnic', cnic);
    await prefs.setString('phone', phone);
    await prefs.setString('role', role);

    print('User data stored successfully.');
  }

  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear(); // Clear all saved data
  }

  Future<bool> updateUserProfile(UserProfile userProfile) async {
    final url = Uri.parse('$baseUrl/users/${userProfile.userId}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userProfile.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update user profile: ${response.body}');
    }
  }

  Future<UserProfile?> getCurrentUser(int userId) async {
    final url = Uri.parse('$baseUrl/users/$userId');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserProfile.fromJson(data); // Convert to UserProfile
    } else {
      throw Exception('Failed to fetch user profile: ${response.body}');
    }
  }
}
