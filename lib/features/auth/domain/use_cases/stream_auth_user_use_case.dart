import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class StreamAuthUserUseCase {
  final AuthRepository authRepository;

  StreamAuthUserUseCase({required this.authRepository});

  Stream<AuthUser> call() {
    try {
      print('----');
      print(authRepository.authUser);
      print('----');
      
      return authRepository.authUser;
    } catch (e) {
      throw Exception(e);
    }
  }
}
