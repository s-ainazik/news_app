import 'package:flutter/material.dart';
import 'package:lesson_1/core/utils/date_formatter.dart';
import 'package:lesson_1/features/news/domain/models/news_article_model.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({super.key, required this.article, required this.onTap});

  final NewsArticleModel article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 214,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 14,
                    color: Colors.black.withValues(alpha: 0.16),
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                article.urlToImage,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => ColoredBox(
                  color: const Color(0xFFE8ECEF),
                  child: Icon(
                    Icons.image_outlined,
                    color: Colors.grey.shade500,
                    size: 36,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              article.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              article.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 12,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              article.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 3),
            Text(
              formatDate(article.publishedAt),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
