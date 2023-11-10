import 'package:auction_mobile/core/errors/failure.dart';
import 'package:auction_mobile/core/usecases/params/no_params.dart';
import 'package:auction_mobile/core/usecases/usecase.dart';
import 'package:auction_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignOutUseCase extends UseCase<void, NoParams> {
  final AuthRepository authRepository;

  SignOutUseCase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.signOut();
  }
}