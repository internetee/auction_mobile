import 'package:auction_mobile/core/errors/failure.dart';
import 'package:auction_mobile/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:auction_mobile/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:auction_mobile/features/auth/domain/entities/user.dart';
import 'package:auction_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../model/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource, required this.authLocalDataSource});

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserModel userModel = await authRemoteDataSource.signInWithEmailAndPassword(email: email, password: password);
      saveUserDataToCache(userModel);

      return Right(userModel.toEntity());
    } catch (e) {
      return Left(e as Failure);
    }
  }

  @override
  Future<Either<Failure, void>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
Future<Either<Failure, UserModel>> getUserDataFromCache() async {
  try {
    UserModel userModel = await authLocalDataSource.getUser();
    return Right(userModel);
  } catch (e) {
    print(e);
    return Left(CacheFailure(message: e.toString()));
  }
}

  @override
  Future<Either<Failure, bool>> saveUserDataToCache(UserModel user) async {
    try {
      await authLocalDataSource.cacheUser(user);

      return const Right(true);
    } catch (e) {
      return Left(e as Failure);
    }
  }
}
