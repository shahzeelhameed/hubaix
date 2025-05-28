// services/news_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../repository/model/news_model.dart';

class NewsService {
  static const String _apiKey = 'ff3bc21ca9124c81aeaf2d4a96ed2688';
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _bookmarksKey = 'bookmarked_articles';

  Future<List<NewsArticle>> fetchNews(
      {String? category, String? search}) async {
    String query = 'Karachi';
    if (category != null) {
      query += '+$category';
    }
    if (search != null && search.isNotEmpty) {
      query += '+$search';
    }

    final url = Uri.parse('$_baseUrl/everything?'
        'q=$query&'
        'language=en&'
        'sortBy=publishedAt&'
        'apiKey=$_apiKey');

    try {
      final response = await http.get(url);

      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Take more articles, not just the first one
        final news = (data['articles'] as List)
            .map((article) => NewsArticle.fromJson(article))
            .where((article) {
              final content =
                  (article.title + article.description).toLowerCase();
              return content.contains('lyari') || content.contains('karachi');
            })
            .take(10) // Take top 10 articles, adjust as needed
            .toList();

        return news;
      }
      return [];
    } catch (e) {
      print('Error fetching news: $e');
      return [];
    }
  }

  Future<List<String>> getBookmarkedArticles() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_bookmarksKey) ?? [];
  }

  Future<void> toggleBookmark(String articleUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList(_bookmarksKey) ?? [];

    if (bookmarks.contains(articleUrl)) {
      bookmarks.remove(articleUrl);
    } else {
      bookmarks.add(articleUrl);
    }

    await prefs.setStringList(_bookmarksKey, bookmarks);
  }
}
