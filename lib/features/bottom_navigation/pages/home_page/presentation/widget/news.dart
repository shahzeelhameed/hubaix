import 'package:flutter/material.dart';
import 'package:hubaix/config/components/news_card.dart';
import 'package:hubaix/data/book_marks_article.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/repository/repo/home_repositoy.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/repository/model/news_model.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/service/home_service.dart';
import 'package:hubaix/utils/utils.dart';

class NewsList extends StatefulWidget {
  NewsList({super.key, this.searchText});

  String? searchText;

  @override
  State<NewsList> createState() => _NewsState();
}

class _NewsState extends State<NewsList> {
  final NewsService newsService = NewsService();
  String? _selectedCategory;

  final List<String> _categories = [
    'Politics',
    'Sports',
    'Education',
    'Crime',
    'Development',
    'Culture'
  ];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final bookmarks = await newsService.getBookmarkedArticles();
    setState(() {
      bookmarkedArticles = bookmarks.toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildCategoryFilter(),
        FutureBuilder<List<NewsArticle>>(
          future: HomeRepositoryHttp().getNewsArticles(
            searchText: widget.searchText,
            category: _selectedCategory,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Failed to load news'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No news available'));
            }

            final articles = snapshot.data!;

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return NewsCard(
                    article: article,
                    newsService: newsService,
                    onShare: () => Utils.shareArticle(article),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Local News',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {
              widget.searchText = null; // Reset search text
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = selected ? category : null;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
