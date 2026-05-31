import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lesson_1/features/news/data/data_source/api/news_remote_data_source.dart';
import 'package:lesson_1/features/news/data/entities/news_article_entity.dart';

abstract final class _ApiPath {
  static const String news = 'v2/everything';
  static const String apiKey = "9941da606ad2474c8a3c60939772cada";
}

@LazySingleton(as: NewsRemoteDataSource)
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  const NewsRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List<NewsArticleEntity>> getNews({
    required String query,
    int? page,
    int? pageSize,
  }) async {
    final queryParameters = {
      'q': query,
      'sortBy': 'publishedAt',
      'apiKey': _ApiPath.apiKey,
    };

    if (page != null) {
      queryParameters['page'] = page.toString();
    }

    if (pageSize != null) {
      queryParameters['pageSize'] = pageSize.toString();
    }

    final response = await dio.get(
      _ApiPath.news,
      queryParameters: queryParameters,
    );
    return NewsArticleEntity.fromJsonList(response.data["articles"]);
  }
}
