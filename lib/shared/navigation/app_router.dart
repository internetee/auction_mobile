import 'dart:async';

import 'package:auction_mobile/features/auction/presentation/screens/auction_screen.dart';
import 'package:auction_mobile/features/offer/presentation/screens/offers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../app/blocs/app/app_bloc.dart';

class AppRouter {
  final AppBloc appBloc;

  AppRouter(this.appBloc);

  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: 'auctions',
        path: '/',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const AuctionScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        name: 'sign-in',
        path: '/sign-in',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const SignInScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        name: 'sign-up',
        path: '/sign-up',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const SignUpScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        name: 'offers',
        path: '/offers',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: OffersScreen(
            authUser: appBloc.state.authUser,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
        redirect: _authHandler,
      )
    ],
    refreshListenable: GoRouterRefreshStream(appBloc.stream),
  );

  String? _authHandler(BuildContext context, GoRouterState state) {
    final bool isAuthenticated = appBloc.state.status == AppStatus.authenticated;
    final bool isSignIn = state.matchedLocation == '/sign-in';
    final bool isSignUp = state.matchedLocation == '/sign-up';

    print("AHHHUUUU");
    print(appBloc.state.authUser);
    print("AHHHUUUU");

    // If user is not authenticated, redirect to the sign-in or sign-up page
    if (!isAuthenticated) {
      return isSignUp ? '/sign-up' : '/sign-in';
    }

    // If user is authenticated and tries to access the sign-in page, redirect to home
    if (isAuthenticated && isSignIn) {
      return '/';
    }
    // If user is authenticated and tries to access the sign-up page, redirect to home
    if (isAuthenticated && isSignUp) {
      return '/';
    }

    // In all other cases, no redirection is needed
    return null;
  }
}

// https://github.com/flutter/flutter/issues/108128
// https://github.com/csells/go_router/discussions/122
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
