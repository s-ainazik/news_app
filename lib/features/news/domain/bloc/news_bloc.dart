import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lesson_1/features/news/domain/bloc/news_event.dart';
import 'package:lesson_1/features/news/domain/bloc/news_state.dart';
import 'package:lesson_1/features/news/domain/usecases/get_news_usecase.dart';

@injectable
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({required this.getNewsUseCase}) : super(const NewsInitial()) {
    on<GetNewsEvent>(_getNewsEvent);
  }

  final GetNewsUseCase getNewsUseCase;
  static const List<({String title, String query})> _categories = [
    (title: 'Trending', query: 'world news'),
    (title: 'Technology', query: 'technology'),
    (title: 'Business', query: 'business'),
    (title: 'Sport', query: 'sport'),
  ];

  Future<void> _getNewsEvent(
    GetNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(const NewsLoading());

    try {
      final query = event.query?.trim();

      if (query != null && query.isNotEmpty) {
        final news = await getNewsUseCase(query: query);
        emit(NewsSuccess([NewsSection(title: 'Search results', news: news)]));
        return;
      }

      final sections = await Future.wait(
        _categories.map((category) async {
          final news = await getNewsUseCase(query: category.query);
          return NewsSection(title: category.title, news: news);
        }),
      );

      emit(NewsSuccess(sections));
    } catch (error) {
      emit(NewsFailure(error.toString()));
    }
  }
}
