import 'package:auction_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

import 'features/auth/data/datasource/auth_remote_data_source.dart';
import 'features/auth/data/datasource/auth_remote_data_source_impl.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'shared/app/app.dart';

typedef AppBuilder = Future<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(await builder());
}

void main() {
  bootstrap(() async {
    AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSourceImpl();
    AuthRepository authRepository = AuthRepositoryImpl(
      remoteDataSource: authRemoteDataSource,
    );

    return App(
      authRepository: authRepository,
      authUser: await authRepository.authUser.first,
    );
  });
}
