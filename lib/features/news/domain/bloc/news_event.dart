import 'package:equatable/equatable.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class GetNewsEvent extends NewsEvent {
  const GetNewsEvent({this.query, this.page, this.pageSize});

  final String? query;
  final int? page;
  final int? pageSize;

  @override
  List<Object?> get props => [query, page, pageSize];
}
