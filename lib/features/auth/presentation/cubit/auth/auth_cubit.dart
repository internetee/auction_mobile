import 'package:auction_mobile/core/errors/failure.dart';
import 'package:auction_mobile/core/usecases/params/no_params.dart';
import 'package:auction_mobile/features/auth/domain/use_cases/get_user_data_from_cache_use_case.dart';
import 'package:auction_mobile/features/auth/domain/use_cases/sign_in_with_email_and_password_use_case.dart';
import 'package:auction_mobile/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithEmailAndPasswordUseCase signInWithEmailAndPasswordUseCase;
  final GetUserDataFromCacheUseCase getUserDataFromCacheUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit({ required this.signInWithEmailAndPasswordUseCase, required this.getUserDataFromCacheUseCase, required this.signOutUseCase }) : super(const AuthState.unknown());

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(const AuthState.loading());
    final result = await signInWithEmailAndPasswordUseCase(SignInWithEmailAndPasswordParams(email: email, password: password));

    result.fold(
      (failure) => emit(AuthState.unauthenticated(message: _mapFailureToMessage(failure))),
      (user) => emit(AuthState.authenticated(user: user)),
    );
  }

  Future<void> getUserDataFromCache() async {
    emit(const AuthState.loading());
    final result = await getUserDataFromCacheUseCase(NoParams());

    result.fold(
      (failure) => emit(AuthState.unauthenticated(message: _mapFailureToMessage(failure))),
      (user) => emit(AuthState.authenticated(user: user)),
    );
  }

  Future<void> signOut() async {
    emit(const AuthState.loading());
    final result = await signOutUseCase(NoParams());

    result.fold(
      (failure) => emit(AuthState.unauthenticated(message: _mapFailureToMessage(failure))),
      (_) => emit(const AuthState.unauthenticated(message: 'Signed out')),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
