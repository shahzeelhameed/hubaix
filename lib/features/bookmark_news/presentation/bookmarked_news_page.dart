// pages/bookmarked_news_page.dart
import 'package:flutter/material.dart';
import 'package:hubaix/config/components/book_mark_news_card.dart';
import '../../bottom_navigation/pages/home_page/repository/model/news_model.dart';
import '../../bottom_navigation/pages/home_page/service/home_service.dart';

class BookmarkedNewsPage extends StatefulWidget {
  const BookmarkedNewsPage({super.key});

  @override
  _BookmarkedNewsPageState createState() => _BookmarkedNewsPageState();
}

class _BookmarkedNewsPageState extends State<BookmarkedNewsPage> {
  final NewsService _newsService = NewsService();
  List<NewsArticle> _bookmarkedNews = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookmarkedNews();
  }

  Future<void> _loadBookmarkedNews() async {
    setState(() => _isLoading = true);
    final bookmarkedUrls = await _newsService.getBookmarkedArticles();

    final allNews = await _newsService.fetchNews();
    setState(() {
      _bookmarkedNews = allNews
          .where((article) => bookmarkedUrls.contains(article.url))
          .toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked News'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _bookmarkedNews.isEmpty
              ? const Center(child: Text('No bookmarked news'))
              : ListView.builder(
                  itemCount: _bookmarkedNews.length,
                  itemBuilder: (context, index) {
                    final article = _bookmarkedNews[index];
                    return BookMarkNewsCard(article: article);
                  },
                ),
    );
  }
}
