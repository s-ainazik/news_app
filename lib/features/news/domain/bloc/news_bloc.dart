import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_1/features/news/domain/bloc/news_event.dart';
import 'package:lesson_1/features/news/domain/bloc/news_state.dart';
import 'package:lesson_1/features/news/domain/repo/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({required this.newsRepository}) : super(const NewsInitial()) {
    on<GetNewsEvent>(_getNewsEvent);
  }

  final NewsRepository newsRepository;

  Future<void> _getNewsEvent(
    GetNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(const NewsLoading());

    try {
      final news = await newsRepository.getNews();
      emit(NewsSuccess(news));
    } catch (error) {
      emit(NewsFailure(error.toString()));
    }
  }
}