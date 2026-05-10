import 'package:lesson_1/features/news/data/data_source/api/news_remote_data_source.dart';
import 'package:lesson_1/features/news/domain/models/news_article_model.dart';
import 'package:lesson_1/features/news/domain/repo/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  const NewsRepositoryImpl({required this.newsRemoteDataSource});

  final NewsRemoteDataSource newsRemoteDataSource;

  @override
  Future<List<NewsArticleModel>> getNews() async {
    final result = await newsRemoteDataSource.getNews();
    return result.map((entity)=> entity.fromEntityToModel()).toList();
  }
}