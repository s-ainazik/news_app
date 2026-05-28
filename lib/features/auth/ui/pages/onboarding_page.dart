import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lesson_1/core/di/app_dependencies.dart';
import 'package:lesson_1/core/router/app_router.gr.dart';
import 'package:lesson_1/features/auth/domain/auth_cubit.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  Future<void> _finish(BuildContext context) async {
    await getIt<AuthCubit>().completeOnboarding();

    if (context.mounted) {
      context.router.replaceAll([const LoginRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _finish(context),
                  child: const Text('Пропустить'),
                ),
              ),
              const Spacer(),
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(
                  Icons.newspaper,
                  color: Colors.deepPurple,
                  size: 44,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Новости, которые удобно читать',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.08,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Сохраняйте интересные материалы, ищите свежие темы и возвращайтесь к приложению без повторного входа.',
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.grey.shade700,
                  height: 1.45,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: () => _finish(context),
                  child: const Text('Начать'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
