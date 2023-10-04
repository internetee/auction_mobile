import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';
import '../value_objects/email.dart';
import '../value_objects/password.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<AuthUser> call(SignUpParams params) async {
    try {
      return await authRepository.signUp(
        email: params.email.value,
        password: params.password.value,
      );
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}

class SignUpParams {
  final Email email;
  final Password password;

  SignUpParams({required this.email, required this.password});
}
