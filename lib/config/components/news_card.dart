import 'package:flutter/material.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/repository/model/news_model.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/service/home_service.dart';
import 'package:hubaix/utils/validations.dart';

class NewsCard extends StatefulWidget {
  final NewsArticle article;
  final NewsService newsService;
  final VoidCallback onShare;

  const NewsCard({
    super.key,
    required this.article,
    required this.newsService,
    required this.onShare,
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _loadBookmarkState();
  }

  Future<void> _loadBookmarkState() async {
    final bookmarks = await widget.newsService.getBookmarkedArticles();
    setState(() {
      isBookmarked = bookmarks.contains(widget.article.url);
    });
  }

  Future<void> _toggleBookmark() async {
    await widget.newsService.toggleBookmark(widget.article.url);
    _loadBookmarkState(); // refresh only this card
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(
                article.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  article.description,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Validations.formatDate(article.publishedAt),
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: isBookmarked ? Colors.blue : null,
                          ),
                          onPressed: _toggleBookmark,
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: widget.onShare,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
