import '../models/auth_user_model.dart';

abstract class AuthRemoteDataSource {
  Stream<AuthUserModel?> get user;

  Future<AuthUserModel?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<AuthUserModel?> signUpUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
