import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lesson_1/core/di/app_dependencies.dart';
import 'package:lesson_1/core/router/app_router.dart';
import 'package:lesson_1/features/news/data/data_source/impl/news_remote_data_source_impl.dart';
import 'package:lesson_1/features/news/data/repo_impl/news_repository_impl.dart';
import 'package:lesson_1/features/news/domain/repo/news_repository.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://newsapi.org/',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  final talker = TalkerFlutter.init();

  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: false,
        printResponseData: true,
        printResponseMessage: true,
        printResponseHeaders: true,
        printResponseTime: true,
        hiddenHeaders: {'X-Api-Key'},
      ),
    ),
  );

  final dataSource = NewsRemoteDataSourceImpl(
    dio: dio,
  );

  final repo = NewsRepositoryImpl(
    newsRemoteDataSource: dataSource,
  );

  runApp(
    MyApp(
      newsRepo: repo,
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.newsRepo,
  });

  final NewsRepository newsRepo;

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      newsRepository: newsRepo,

      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,

        title: 'News App',

        theme: ThemeData(
          useMaterial3: true,

          scaffoldBackgroundColor:
              const Color(0xFFF5F5F5),

          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),

          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
        ),

        routerConfig: _appRouter.config(),
      ),
    );
  }
}