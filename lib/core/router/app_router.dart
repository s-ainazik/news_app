import 'package:auto_route/auto_route.dart';
import 'package:lesson_1/core/router/app_router.gr.dart';

import 'package:lesson_1/features/news/ui/pages/news_page.dart';
import 'package:lesson_1/features/news/ui/pages/news_details_page.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: NewsRoute.page,
          initial: true,
        ),

        AutoRoute(
          page: NewsDetailsRoute.page,
        ),
      ];
}