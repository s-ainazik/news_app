import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lesson_1/features/auth/data/auth_secure_storage.dart';
import 'package:lesson_1/features/auth/domain/auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._storage) : super(const AuthInitial());

  final AuthSecureStorage _storage;

  Future<void> checkStatus() async {
    emit(const AuthLoading());

    final onboardingCompleted = await _storage.isOnboardingCompleted();
    if (!onboardingCompleted) {
      emit(const AuthOnboardingRequired());
      return;
    }

    final isAuthenticated = await _storage.isAuthenticated();
    if (!isAuthenticated) {
      emit(const AuthUnauthenticated());
      return;
    }

    final email = await _storage.getEmail();
    emit(AuthAuthenticated(email: email ?? 'User'));
  }

  Future<void> completeOnboarding() async {
    await _storage.completeOnboarding();
    emit(const AuthUnauthenticated());
  }

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());
    await _storage.saveSession(email: email);
    emit(AuthAuthenticated(email: email));
  }

  Future<void> logout() async {
    await _storage.logout();
    emit(const AuthUnauthenticated());
  }
}
