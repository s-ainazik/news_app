import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_1/core/di/app_dependencies.dart';
import 'package:lesson_1/core/router/app_router.gr.dart';
import 'package:lesson_1/features/auth/domain/auth_cubit.dart';
import 'package:lesson_1/features/auth/domain/auth_state.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final AuthCubit _authCubit = getIt<AuthCubit>()..checkStatus();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          switch (state) {
            case AuthOnboardingRequired():
              context.router.replaceAll([const OnboardingRoute()]);
            case AuthUnauthenticated():
              context.router.replaceAll([const LoginRoute()]);
            case AuthAuthenticated():
              context.router.replaceAll([const HomeRoute()]);
            default:
              break;
          }
        },
        child: const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
