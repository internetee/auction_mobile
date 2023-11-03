import 'package:auction_mobile/configs/locator_service.dart';
import 'package:auction_mobile/features/auth/domain/entities/user.dart';
import 'package:auction_mobile/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../navigation/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    User user = User.empty;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => sl<AuthCubit>()..getUserDataFromCache(),
        ),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            user = state.user;
          }
        },
        builder: (context, state) {
          return AppView(user: user);
        },
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final User user;

  const AppView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EIS Domain Auction App',
      // theme: AppTheme.theme,
      routerConfig: AppRouter(user: user).router,
    );
  }
}
