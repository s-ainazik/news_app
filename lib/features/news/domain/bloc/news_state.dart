import 'package:equatable/equatable.dart';
import 'package:lesson_1/features/news/domain/models/news_article_model.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {
  const NewsInitial();
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsSuccess extends NewsState {
  const NewsSuccess(this.sections);

  final List<NewsSection> sections;

  @override
  List<Object?> get props => [sections];
}

class NewsSection extends Equatable {
  const NewsSection({required this.title, required this.news});

  final String title;
  final List<NewsArticleModel> news;

  @override
  List<Object?> get props => [title, news];
}

class NewsFailure extends NewsState {
  const NewsFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
