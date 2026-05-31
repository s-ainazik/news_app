import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lesson_1/core/di/app_dependencies.dart';
import 'package:lesson_1/core/router/app_router.gr.dart';
import 'package:lesson_1/core/utils/date_formatter.dart';
import 'package:lesson_1/features/news/domain/models/news_article_model.dart';
import 'package:lesson_1/features/news/domain/usecases/get_news_usecase.dart';

class EverythingPage extends StatefulWidget {
  const EverythingPage({super.key});

  @override
  State<EverythingPage> createState() => _EverythingPageState();
}

class _EverythingPageState extends State<EverythingPage> {
  final ScrollController _scrollController = ScrollController();
  final List<NewsArticleModel> _news = [];

  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String? _errorText;

  static const int _pageSize = 20;
  static const int _maxNews = 100;
  static const int _maxPage = 5;

  @override
  void initState() {
    super.initState();
    _loadNews();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 250) {
      _loadNews();
    }
  }

  Future<void> _loadNews() async {
    if (_isLoading || _page > _maxPage || _news.length >= _maxNews) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      final result = await getIt<GetNewsUseCase>()(
        query: 'news',
        page: _page,
        pageSize: _pageSize,
      );

      if (!mounted) return;

      setState(() {
        final freePlaces = _maxNews - _news.length;
        _news.addAll(result.take(freePlaces));
        _page++;
        _hasMore = _page <= _maxPage && _news.length < _maxNews;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _errorText = error.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
          itemCount: _news.length + 2,
          separatorBuilder: (_, index) {
            if (index == 0) return const SizedBox(height: 18);
            return const SizedBox(height: 22);
          },
          itemBuilder: (context, index) {
            if (index == 0) {
              return const _EverythingHeader();
            }

            if (index == _news.length + 1) {
              return _BottomLoader(
                isLoading: _isLoading,
                hasMore: _hasMore,
                errorText: _errorText,
                onRetry: _loadNews,
              );
            }

            final article = _news[index - 1];

            return _EverythingNewsItem(
              article: article,
              onTap: () {
                context.pushRoute(NewsDetailsRoute(article: article));
              },
            );
          },
        ),
      ),
    );
  }
}

class _EverythingHeader extends StatelessWidget {
  const _EverythingHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Everything',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}

class _BottomLoader extends StatelessWidget {
  const _BottomLoader({
    required this.isLoading,
    required this.hasMore,
    required this.errorText,
    required this.onRetry,
  });

  final bool isLoading;
  final bool hasMore;
  final String? errorText;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (errorText != null) {
      return Column(
        children: [
          Text(
            'Ошибка загрузки',
            style: TextStyle(
              color: Colors.red.shade700,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton(onPressed: onRetry, child: const Text('Повторить')),
        ],
      );
    }

    if (!hasMore) {
      return Center(
        child: Text(
          'Новости закончились',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return const SizedBox(height: 8);
  }
}

class _EverythingNewsItem extends StatelessWidget {
  const _EverythingNewsItem({required this.article, required this.onTap});

  final NewsArticleModel article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12,
                  color: Colors.black.withValues(alpha: 0.12),
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              article.urlToImage,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => ColoredBox(
                color: const Color(0xFFE8ECEF),
                child: Icon(
                  Icons.image_outlined,
                  color: Colors.grey.shade500,
                  size: 30,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: SizedBox(
              height: 92,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    article.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 12,
                      height: 1.2,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          article.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        formatDate(article.publishedAt),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
