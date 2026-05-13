import 'package:injectable/injectable.dart';
import 'package:lesson_1/features/news/data/data_source/api/news_remote_data_source.dart';
import 'package:lesson_1/features/news/domain/models/news_article_model.dart';
import 'package:lesson_1/features/news/domain/repo/news_repository.dart';

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  const NewsRepositoryImpl({required this.newsRemoteDataSource});

  final NewsRemoteDataSource newsRemoteDataSource;

  @override
  Future<List<NewsArticleModel>> getNews({required String query}) async {
    final result = await newsRemoteDataSource.getNews(query: query);
    return result.map((entity) => entity.fromEntityToModel()).toList();
  }
}
