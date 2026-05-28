// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:lesson_1/features/auth/ui/pages/login_page.dart' as _i2;
import 'package:lesson_1/features/auth/ui/pages/onboarding_page.dart' as _i5;
import 'package:lesson_1/features/auth/ui/pages/splash_page.dart' as _i6;
import 'package:lesson_1/features/news/domain/models/news_article_model.dart'
    as _i9;
import 'package:lesson_1/features/news/ui/pages/home_page.dart' as _i1;
import 'package:lesson_1/features/news/ui/pages/news_details_page.dart' as _i3;
import 'package:lesson_1/features/news/ui/pages/news_page.dart' as _i4;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginPage();
    },
  );
}

/// generated route for
/// [_i3.NewsDetailsPage]
class NewsDetailsRoute extends _i7.PageRouteInfo<NewsDetailsRouteArgs> {
  NewsDetailsRoute({
    _i8.Key? key,
    required _i9.NewsArticleModel article,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         NewsDetailsRoute.name,
         args: NewsDetailsRouteArgs(key: key, article: article),
         initialChildren: children,
       );

  static const String name = 'NewsDetailsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewsDetailsRouteArgs>();
      return _i3.NewsDetailsPage(key: args.key, article: args.article);
    },
  );
}

class NewsDetailsRouteArgs {
  const NewsDetailsRouteArgs({this.key, required this.article});

  final _i8.Key? key;

  final _i9.NewsArticleModel article;

  @override
  String toString() {
    return 'NewsDetailsRouteArgs{key: $key, article: $article}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewsDetailsRouteArgs) return false;
    return key == other.key && article == other.article;
  }

  @override
  int get hashCode => key.hashCode ^ article.hashCode;
}

/// generated route for
/// [_i4.NewsPage]
class NewsRoute extends _i7.PageRouteInfo<void> {
  const NewsRoute({List<_i7.PageRouteInfo>? children})
    : super(NewsRoute.name, initialChildren: children);

  static const String name = 'NewsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.NewsPage();
    },
  );
}

/// generated route for
/// [_i5.OnboardingPage]
class OnboardingRoute extends _i7.PageRouteInfo<void> {
  const OnboardingRoute({List<_i7.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.OnboardingPage();
    },
  );
}

/// generated route for
/// [_i6.SplashPage]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SplashPage();
    },
  );
}
