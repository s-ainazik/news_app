import 'package:lesson_1/features/news/data/entities/news_article_entity.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsArticleEntity>> getNews({required String query});
}
