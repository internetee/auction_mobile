import 'package:auction_mobile/features/auction/domain/repositories/auction_repository.dart';
import 'package:auction_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:auction_mobile/features/offer/domain/entities/offer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/domain/entities/auth_user.dart';
import '../../features/auth/domain/use_cases/sign_out_use_case.dart';
import '../../features/auth/domain/use_cases/stream_auth_user_use_case.dart';
import '../../features/offer/domain/repositories/offer_repository.dart';
import '../navigation/app_router.dart';
import 'blocs/app/app_bloc.dart';

class App extends StatelessWidget {
  const App({
    required AuthRepository authRepository,
    required AuctionRepository auctionRepository,
    required OfferRepository offerRepository,
    required AuthUser authUser, super.key})
      : _authRepository = authRepository,
        _auctionRepository = auctionRepository,
        _offerRepository = offerRepository,
        _authUser = authUser;

  final AuthRepository _authRepository;
  final AuthUser _authUser;
  final AuctionRepository _auctionRepository;
  final OfferRepository _offerRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: _authRepository),
          RepositoryProvider.value(value: _auctionRepository),
          RepositoryProvider.value(value: _offerRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AppBloc(
                streamAuthUserUseCase: StreamAuthUserUseCase(
                  authRepository: _authRepository,
                ),
                signOutUseCase: SignOutUseCase(
                  authRepository: _authRepository,
                ),
                authUser: _authUser,
              )..add(AppUserChanged(_authUser)),
            )
          ],
          child: const AppView(),
        ));
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EIS Auction app',
      // theme: AppTheme.theme,
      routerConfig: AppRouter(context.read<AppBloc>()).router,
    );
  }
}
