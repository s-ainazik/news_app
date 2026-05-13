import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:lesson_1/core/di/app_dependencies.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
