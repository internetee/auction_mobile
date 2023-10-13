import 'package:auction_mobile/features/auction/data/datasource/auction_remote_data_source.dart';
import 'package:auction_mobile/features/auction/domain/repositories/auction_repository.dart';
import 'package:auction_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

import 'features/auction/data/datasource/auction_remote_data_source_impl.dart';
import 'features/auction/data/repositories/auction_repository_impl.dart';
import 'features/auth/data/datasource/auth_remote_data_source.dart';
import 'features/auth/data/datasource/auth_remote_data_source_impl.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'shared/app/app.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

typedef AppBuilder = Future<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(await builder());
}

void main() {
  bootstrap(() async {
    AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSourceImpl(http.Client());
    AuthRepository authRepository = AuthRepositoryImpl(
      remoteDataSource: authRemoteDataSource,
    );

    AuctionRemoteDataSource auctionRemoteDataSource = AuctionRemoteDataSourceImpl(http.Client(),);
    AuctionRepository auctionRepository = AuctionRepositoryImpl(auctionRemoteDataSource: auctionRemoteDataSource,);

    return App(
      auctionRepository: auctionRepository,
      authRepository: authRepository,
      authUser: await authRepository.authUser.first,
    );
  });
}
