import 'package:auction_mobile/features/auth/data/model/user_model.dart';
import 'package:auction_mobile/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signInWithEmailAndPassword(String email, String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserModel>> getUserDataFromCache();
  Future<Either<Failure, bool>> saveUserDataToCache(UserModel user);
}
