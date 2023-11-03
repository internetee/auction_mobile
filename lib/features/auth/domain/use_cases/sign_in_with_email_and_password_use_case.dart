import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmailAndPasswordUseCase extends UseCase<User, SignInWithEmailAndPasswordParams> {
  final AuthRepository authRepository;

  SignInWithEmailAndPasswordUseCase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(SignInWithEmailAndPasswordParams params) async {
    return await authRepository.signInWithEmailAndPassword(params.email, params.password);
  }
}

class SignInWithEmailAndPasswordParams extends Equatable {
  final String email;
  final String password;

  const SignInWithEmailAndPasswordParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
