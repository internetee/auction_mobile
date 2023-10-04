import '../models/auth_user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const fakeUser = AuthUserModel(
    uuid: 'fake-user-id',
    email: 'fake-user-email',
    givenName: 'fake-user-name',
    surname: 'fake-user-name',
  );

  @override
  Stream<AuthUserModel?> get user {
    return Stream.value(fakeUser);
  }

  @override
  Future<AuthUserModel> signUpUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return fakeUser;
  }

  @override
  Future<AuthUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return fakeUser;
  }

  @override
  Future<void> signOut() async {
    throw UnimplementedError();
  }
}
