import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Stream<AuthUser> get authUser {
    return remoteDataSource.user.map((authUserModel) {
      // if (authUserModel != null) {
      //   localDataSource.write(key: 'user', value: authUserModel);
      // } else {
      //   localDataSource.write(key: 'user', value: null);
      // }

      return authUserModel == null ? AuthUser.empty : authUserModel.toEntity();
    });
  }

  @override
  Future<AuthUser> signUp({
    required String email,
    required String password,
  }) async {
    final authModel = await remoteDataSource.signUpUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // localDataSource.write(key: 'user', value: authModel);

    return authModel!.toEntity();
  }

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    final authModel = await remoteDataSource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // localDataSource.write(key: 'user', value: authModel);

    return authModel!.toEntity();
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();

    // localDataSource.write(key: 'user', value: null);
  }
}