import 'package:auction_mobile/core/errors/failure.dart';
import 'package:auction_mobile/core/usecases/params/no_params.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetUserDataFromCacheUseCase extends UseCase<User, NoParams> {
  final AuthRepository authRepository;

  GetUserDataFromCacheUseCase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.getUserDataFromCache().then((value) => value.fold((l) => Left(l), (r) => Right(r.toEntity())));
  }
}
