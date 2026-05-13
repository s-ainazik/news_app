import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_1/core/di/app_dependencies.dart';
import 'package:lesson_1/core/router/app_router.gr.dart';
import 'package:lesson_1/features/news/domain/bloc/news_bloc.dart';
import 'package:lesson_1/features/news/domain/bloc/news_event.dart';
import 'package:lesson_1/features/news/domain/bloc/news_state.dart';
import 'package:lesson_1/features/news/domain/models/news_article_model.dart';
import 'package:lesson_1/features/news/ui/widgets/news_tile.dart';

@RoutePage()
class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(BuildContext context) {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      context.read<NewsBloc>().add(const GetNewsEvent());
      return;
    }

    context.read<NewsBloc>().add(GetNewsEvent(query: query));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NewsBloc>()..add(const GetNewsEvent()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Text(
                  'Hi',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 18),
                child: Text(
                  "Let's find something new...",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Builder(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                    child: TextField(
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) => _search(context),
                      decoration: InputDecoration(
                        hintText: 'Поиск новостей',
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () => _search(context),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(color: Colors.grey.shade300),
              ),
              Expanded(
                child: BlocBuilder<NewsBloc, NewsState>(
                  builder: (context, state) {
                    if (state is NewsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is NewsFailure) {
                      return Center(
                        child: Text(
                          'Ошибка запроса: ${state.message}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    if (state is NewsSuccess) {
                      final sections = state.sections
                          .where((section) => section.news.isNotEmpty)
                          .toList();

                      if (sections.isEmpty) {
                        return const Center(
                          child: Text(
                            'Нет новостей.\nПроверьте текст поиска или API key.',
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 28),
                        itemCount: sections.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 22),
                        itemBuilder: (context, index) {
                          final section = sections[index];

                          return _NewsSectionView(
                            section: section,
                            onArticleTap: (article) {
                              context.pushRoute(
                                NewsDetailsRoute(article: article),
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
            ],
          ),
        ),
      ),
    );
  }
}

class _NewsSectionView extends StatelessWidget {
  const _NewsSectionView({required this.section, required this.onArticleTap});

  final NewsSection section;
  final ValueChanged<NewsArticleModel> onArticleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            section.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 360,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: section.news.length,
            separatorBuilder: (_, _) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final article = section.news[index];

              return NewsTile(
                article: article,
                onTap: () => onArticleTap(article),
              );
            },
          ),
        ),
      ],
    );
  }
}
