import 'package:lesson_1/features/news/domain/models/news_article_model.dart';

abstract class NewsRepository {
  Future<List<NewsArticleModel>> getNews ();
}