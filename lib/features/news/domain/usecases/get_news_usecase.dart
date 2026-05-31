import 'package:injectable/injectable.dart';
import 'package:lesson_1/features/news/domain/models/news_article_model.dart';
import 'package:lesson_1/features/news/domain/repo/news_repository.dart';

@injectable
class GetNewsUseCase {
  const GetNewsUseCase({required this.newsRepository});

  final NewsRepository newsRepository;

  Future<List<NewsArticleModel>> call({
    required String query,
    int? page,
    int? pageSize,
  }) {
    return newsRepository.getNews(query: query, page: page, pageSize: pageSize);
  }
}
