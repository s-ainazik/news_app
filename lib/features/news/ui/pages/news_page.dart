import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_1/core/di/app_dependencies.dart';
import 'package:lesson_1/core/router/app_router.gr.dart';
import 'package:lesson_1/features/news/domain/bloc/news_bloc.dart';
import 'package:lesson_1/features/news/domain/bloc/news_event.dart';
import 'package:lesson_1/features/news/domain/bloc/news_state.dart';
import 'package:lesson_1/features/news/ui/widgets/news_tile.dart';

@RoutePage()
class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return BlocProvider(
      create: (_) =>
          NewsBloc(newsRepository: dependencies.newsRepository)
            ..add(const GetNewsEvent()),

      child: Scaffold(
        appBar: AppBar(title: const Text('News'), centerTitle: true),

        body: SafeArea(
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is NewsFailure) {
                return Center(
                  child: Text(
                    'Ошибка запроса: ${state.message}',
                    style: const TextStyle(fontSize: 20, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (state is NewsSuccess) {
                final list = state.news;

                if (list.isEmpty) {
                  return const Center(
                    child: Text(
                      'Нет новостей.\nПроверьте интернет или API key.',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: list.length,

                  itemBuilder: (context, pos) {
                    final news = list[pos];

                    return NewsTile(
                      article: news,

                      onTap: () {
                        context.pushRoute(
                          NewsDetailsRoute(
                            title: news.title,
                            description: news.description,
                            author: news.author,
                            imageUrl: news.urlToImage,
                            date: news.publishedAt,
                            content: news.content,
                          ),
                        );
                      },
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
