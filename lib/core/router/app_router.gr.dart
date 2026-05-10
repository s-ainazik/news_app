// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:lesson_1/features/news/ui/pages/news_details_page.dart' as _i1;
import 'package:lesson_1/features/news/ui/pages/news_page.dart' as _i2;

/// generated route for
/// [_i1.NewsDetailsPage]
class NewsDetailsRoute extends _i3.PageRouteInfo<NewsDetailsRouteArgs> {
  NewsDetailsRoute({
    _i4.Key? key,
    required String title,
    required String description,
    required String author,
    required String imageUrl,
    required String date,
    required String content,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         NewsDetailsRoute.name,
         args: NewsDetailsRouteArgs(
           key: key,
           title: title,
           description: description,
           author: author,
           imageUrl: imageUrl,
           date: date,
           content: content,
         ),
         initialChildren: children,
       );

  static const String name = 'NewsDetailsRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewsDetailsRouteArgs>();
      return _i1.NewsDetailsPage(
        key: args.key,
        title: args.title,
        description: args.description,
        author: args.author,
        imageUrl: args.imageUrl,
        date: args.date,
        content: args.content,
      );
    },
  );
}

class NewsDetailsRouteArgs {
  const NewsDetailsRouteArgs({
    this.key,
    required this.title,
    required this.description,
    required this.author,
    required this.imageUrl,
    required this.date,
    required this.content,
  });

  final _i4.Key? key;

  final String title;

  final String description;

  final String author;

  final String imageUrl;

  final String date;

  final String content;

  @override
  String toString() {
    return 'NewsDetailsRouteArgs{key: $key, title: $title, description: $description, author: $author, imageUrl: $imageUrl, date: $date, content: $content}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewsDetailsRouteArgs) return false;
    return key == other.key &&
        title == other.title &&
        description == other.description &&
        author == other.author &&
        imageUrl == other.imageUrl &&
        date == other.date &&
        content == other.content;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      title.hashCode ^
      description.hashCode ^
      author.hashCode ^
      imageUrl.hashCode ^
      date.hashCode ^
      content.hashCode;
}

/// generated route for
/// [_i2.NewsPage]
class NewsRoute extends _i3.PageRouteInfo<void> {
  const NewsRoute({List<_i3.PageRouteInfo>? children})
    : super(NewsRoute.name, initialChildren: children);

  static const String name = 'NewsRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.NewsPage();
    },
  );
}
