import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Talker get talker => TalkerFlutter.init();

  @lazySingleton
  Dio dio(Talker talker) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

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

    return dio;
  }
}
