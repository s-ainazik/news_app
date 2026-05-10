import 'package:lesson_1/features/news/domain/models/news_article_model.dart';

class NewsArticleEntity {
  NewsArticleEntity({
   this.author,
   this.title,
   this.description,
   this.url,
   this.urlToImage,
   this.publishedAt,
   this.content,
  });
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  factory NewsArticleEntity.fromJson(Map<String, dynamic> json) {
    return NewsArticleEntity(
      author: json['author'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String?,
      content: json['content'] as String?,
    );
  }

  static List<NewsArticleEntity> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null || jsonList.isEmpty) return [];

    return jsonList
        .map((e) => NewsArticleEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  NewsArticleModel fromEntityToModel() {
  return NewsArticleModel(
    author: author ?? 'Unknown author',
    title: title ?? 'No title',
    description: description ?? 'No description',
    url: url ?? '',
    urlToImage: urlToImage ?? '',
    publishedAt: publishedAt ?? '',
    content: content ?? '',
  );
}
}
