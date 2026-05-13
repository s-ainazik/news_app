import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lesson_1/core/utils/date_formatter.dart';
import 'package:lesson_1/features/news/domain/models/news_article_model.dart';

@RoutePage()
class NewsDetailsPage extends StatelessWidget {
  const NewsDetailsPage({super.key, required this.article});

  final NewsArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => context.router.maybePop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              Center(
                child: Container(
                  width: 190,
                  height: 245,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 24,
                        color: Colors.black.withValues(alpha: 0.18),
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    article.urlToImage,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => ColoredBox(
                      color: const Color(0xFFE8ECEF),
                      child: Icon(
                        Icons.image_outlined,
                        color: Colors.grey.shade500,
                        size: 44,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              Center(
                child: Text(
                  article.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    height: 1.15,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  article.author,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 17,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(height: 26),
              Divider(color: Colors.grey.shade200),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _NewsInfoItem(
                      label: 'Дата',
                      value: formatDate(article.publishedAt),
                    ),
                  ),
                  Expanded(
                    child: _NewsInfoItem(label: 'Автор', value: article.author),
                  ),
                  Expanded(
                    child: _NewsInfoItem(
                      label: 'Источник',
                      value: article.url.isEmpty ? 'NewsAPI' : 'Ссылка',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                'Описание',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                article.description,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                article.content,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewsInfoItem extends StatelessWidget {
  const _NewsInfoItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            height: 1.15,
          ),
        ),
      ],
    );
  }
}
