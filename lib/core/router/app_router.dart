import 'package:auto_route/auto_route.dart';
import 'package:lesson_1/core/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),

    AutoRoute(page: NewsDetailsRoute.page),
  ];
}
