import 'package:auction_mobile/configs/locator_service.dart';
import 'package:auction_mobile/features/auction/presentation/blocs/websocket/websocket_cubit.dart';
import 'package:auction_mobile/features/auth/domain/entities/user.dart';
import 'package:auction_mobile/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../navigation/app_router.dart';

class App extends StatelessWidget {
  App({super.key});

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    User user = User.empty;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => sl<AuthCubit>()..getUserDataFromCache(),
        ),
        BlocProvider<WebsocketCubit>(
          create: (context) => sl<WebsocketCubit>()..fetchAuctionStream(), 
        ),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            user = state.user;
          } else if (state.status == AuthStatus.unauthenticated) {
            user = User.empty;
          }
        },
        builder: (context, state) {
          return AppView(scaffoldMessengerKey: scaffoldMessengerKey, user: user);
        },
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final User user;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  const AppView({super.key, required this.user, required this.scaffoldMessengerKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'EIS Domain Auction App',
      // theme: AppTheme.theme,
      routerConfig: AppRouter(user: user).router,
    );
  }
}
