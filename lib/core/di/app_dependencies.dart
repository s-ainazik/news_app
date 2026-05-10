import 'package:flutter/material.dart';
import 'package:lesson_1/features/news/domain/repo/news_repository.dart';

class AppDependencies extends InheritedWidget {
  const AppDependencies({
    super.key,
    required this.newsRepository,
    required super.child,
  });

  final NewsRepository newsRepository;
  

  static AppDependencies of(BuildContext context) {
    final dependencies = context
        .dependOnInheritedWidgetOfExactType<AppDependencies>();

    assert(dependencies != null, 'AppDependencies not found in context');
    return dependencies!;
  }

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return newsRepository != oldWidget.newsRepository;

  }
}