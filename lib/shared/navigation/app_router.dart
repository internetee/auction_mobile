import 'dart:async';

import 'package:auction_mobile/features/auction/presentation/screens/auction_screen.dart';
import 'package:auction_mobile/features/auth/domain/entities/user.dart';
import 'package:auction_mobile/features/offer/presentation/screens/offers_screen.dart';
import 'package:auction_mobile/shared/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/sign_in_screen.dart';


class AppRouter {
  final User user;

  AppRouter({required this.user});

  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: 'tabs',
        path: '/',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const TabsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        name: 'auctions',
        path: '/auctions',
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
          child: SignInScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      // GoRoute(
      //   name: 'sign-up',
      //   path: '/sign-up',
      //   pageBuilder: (context, state) => CustomTransitionPage<void>(
      //     key: state.pageKey,
      //     child: const SignUpScreen(),
      //     transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
      //   ),
      // ),
      GoRoute(
        name: 'offers',
        path: '/offers',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: OffersScreen(user: User.empty),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
        redirect: _authHandler,
      )
    ]
  );

  String? _authHandler(BuildContext context, GoRouterState state) {
    if (user.tempTokenStore == null) {
      return '/login';
    }

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
