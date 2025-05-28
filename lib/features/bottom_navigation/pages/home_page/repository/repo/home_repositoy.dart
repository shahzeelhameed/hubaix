import 'package:hubaix/features/auth/services/auth_service.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/repository/model/user_profile_model.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/repository/model/news_model.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/service/home_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeRepository {
  Future<UserProfile> getUserData();
  Future<List<NewsArticle>> getNewsArticles(
      {String? searchText, String? category});
  Future<bool> updateUserProfile(UserProfile userProfile);

  Future<bool> logout();
}

class HomeRepositoryHttp implements HomeRepository {
  final NewsService newsService = NewsService();
  final AuthenticationService authService = AuthenticationService();
  @override
  Future<UserProfile> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');
    final userId = prefs.getInt('user_id');
    final username = prefs.getString('username');
    final email = prefs.getString('email');
    final cnic = prefs.getString('cnic');
    final phone = prefs.getString('phone');
    final role = prefs.getString('role');

    if (token == null ||
        userId == null ||
        username == null ||
        email == null ||
        cnic == null ||
        phone == null ||
        role == null) {
      throw Exception('Missing user data in SharedPreferences');
    }

    return UserProfile(
      userId: userId,
      username: username,
      email: email,
      cnicNumber: cnic,
      phoneNumber: phone,
      role: role,
      photoUrl: '', // You can set a default photo URL if needed
    );
  }

  @override
  Future<List<NewsArticle>> getNewsArticles(
      {String? searchText, String? category}) async {
    try {
      final articles = await newsService.fetchNews(
        category: category,
        search: searchText,
      );

      return articles;
    } catch (error) {
      print('Error fetching news articles: $error');
      return [];
    }
  }

  @override
  Future<bool> updateUserProfile(UserProfile userProfile) async {
    final response = await authService.updateUserProfile(userProfile);
    print(response);
    return response;
  }

  @override
  Future<bool> logout() async {
    return await authService.logout();
  }
}
