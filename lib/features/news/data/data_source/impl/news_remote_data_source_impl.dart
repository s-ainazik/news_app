import 'package:dio/dio.dart';
import 'package:lesson_1/features/news/data/data_source/api/news_remote_data_source.dart';
import 'package:lesson_1/features/news/data/entities/news_article_entity.dart';

abstract final class _ApiPath {
  static const String news =
      'v2/everything?q=bishkek&from=2026-05-01&sortBy=publishedAt';
  static const String apiKey = "9941da606ad2474c8a3c60939772cada";
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  const NewsRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List<NewsArticleEntity>> getNews() async {
    final response = await dio.get(
      _ApiPath.news,
      queryParameters: {"apiKey": _ApiPath.apiKey},
    );
    return NewsArticleEntity.fromJsonList(response.data["articles"]);
  }
}
