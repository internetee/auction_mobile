import 'package:auction_mobile/features/auction/data/datasource/auction_remote_data_source.dart';
import 'package:auction_mobile/features/auction/data/datasource/auction_remote_data_source_impl.dart';
import 'package:auction_mobile/features/auction/data/datasource/auction_websocket_data_source.dart';
import 'package:auction_mobile/features/auction/data/repositories/auction_repository_impl.dart';
import 'package:auction_mobile/features/auction/domain/repositories/auction_repository.dart';
import 'package:auction_mobile/features/auction/domain/use_cases/get_auction_stream_use_case.dart';
import 'package:auction_mobile/features/auction/domain/use_cases/get_auctions_use_case.dart';
import 'package:auction_mobile/features/auction/presentation/blocs/auction/auction_bloc.dart';
import 'package:auction_mobile/features/auction/presentation/blocs/websocket/websocket_cubit.dart';
import 'package:auction_mobile/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:auction_mobile/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:auction_mobile/features/auth/data/repository/auth_repository_impl.dart';
import 'package:auction_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:auction_mobile/features/auth/domain/use_cases/get_user_data_from_cache_use_case.dart';
import 'package:auction_mobile/features/auth/domain/use_cases/sign_in_with_email_and_password_use_case.dart';
import 'package:auction_mobile/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:auction_mobile/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:auction_mobile/features/offer/data/datasource/offer_remote_data_source.dart';
import 'package:auction_mobile/features/offer/data/repositories/offer_repository_impl.dart';
import 'package:auction_mobile/features/offer/domain/repositories/offer_repository.dart';
import 'package:auction_mobile/features/offer/domain/use_cases/get_offers_use_case.dart';
import 'package:auction_mobile/features/offer/presentation/blocs/offer/offer_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLOC / Cubit
  sl.registerFactory(() => AuthCubit(signInWithEmailAndPasswordUseCase: sl(), getUserDataFromCacheUseCase: sl(), signOutUseCase: sl()));
  sl.registerFactory(() => AuctionBloc(getAuctionUseCse: GetAuctionUseCse(auctionRepository: sl())));
  sl.registerFactory(() => OfferBloc(getOffersUseCase: GetOffersUseCase(offerRepository: sl())));
  sl.registerFactory(() => WebsocketCubit(getAuctionStreamUseCase: sl()));

  // UseCases
  sl.registerLazySingleton(() => SignInWithEmailAndPasswordUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => GetUserDataFromCacheUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => GetAuctionUseCse(auctionRepository: sl()));
  sl.registerLazySingleton(() => GetAuctionStreamUseCase(sl()));
  sl.registerLazySingleton(() => GetOffersUseCase(offerRepository: sl()));
  sl.registerLazySingleton(() => SignOutUseCase(authRepository: sl()));

  // Repository
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authRemoteDataSource: sl(), authLocalDataSource: sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authRemoteDataSource: sl(), authLocalDataSource: sl()));
  sl.registerLazySingleton<AuctionRepository>(() => AuctionRepositoryImpl(auctionRemoteDataSource: sl(), auctionWebsocketDataSource: sl()));
  sl.registerLazySingleton<OfferRepository>(() => OfferRepositoryImpl(offerRemoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<AuctionRemoteDataSource>(() => AuctionRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuctionWebsocketDataSource>(() => AuctionWebsocketDataSourceImpl());
  sl.registerLazySingleton<OfferRemoteDataSource>(() => OfferRemoteDataSourceImpl(client: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
