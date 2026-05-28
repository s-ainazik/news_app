// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:lesson_1/core/di/register_module.dart' as _i994;
import 'package:lesson_1/features/news/data/data_source/api/news_remote_data_source.dart'
    as _i894;
import 'package:lesson_1/features/news/data/data_source/impl/news_remote_data_source_impl.dart'
    as _i379;
import 'package:lesson_1/features/news/data/repo_impl/news_repository_impl.dart'
    as _i20;
import 'package:lesson_1/features/news/domain/bloc/news_bloc.dart' as _i267;
import 'package:lesson_1/features/news/domain/repo/news_repository.dart'
    as _i329;
import 'package:lesson_1/features/news/domain/usecases/get_news_usecase.dart'
    as _i934;
import 'package:talker_flutter/talker_flutter.dart' as _i207;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i207.Talker>(() => registerModule.talker);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio(gh<_i207.Talker>()));
    gh.lazySingleton<_i894.NewsRemoteDataSource>(
      () => _i379.NewsRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i329.NewsRepository>(
      () => _i20.NewsRepositoryImpl(
        newsRemoteDataSource: gh<_i894.NewsRemoteDataSource>(),
      ),
    );
    gh.factory<_i934.GetNewsUseCase>(
      () => _i934.GetNewsUseCase(newsRepository: gh<_i329.NewsRepository>()),
    );
    gh.factory<_i267.NewsBloc>(
      () => _i267.NewsBloc(getNewsUseCase: gh<_i934.GetNewsUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i994.RegisterModule {}
