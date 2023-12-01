import 'package:auction_mobile/features/auction/presentation/screens/auction_screen.dart';
import 'package:auction_mobile/features/auth/domain/entities/user.dart';
import 'package:auction_mobile/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:auction_mobile/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const logoutIndex = 1;

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  // ignore: prefer_typing_uninitialized_variables
  late AuthCubit authCubit;
  // ignore: prefer_typing_uninitialized_variables
  late User currentUser;

  @override
  void initState() {
    authCubit = context.read<AuthCubit>();
    currentUser = authCubit.state.user;

    super.initState();
  }

  int _selectedIndex = 0;

  void _selectedTab(int index) {
    if (!currentUser.isEmpty && index == logoutIndex) {
      context.read<AuthCubit>().signOut();
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _authNavigationBartItem(User currentUser) {
    if (currentUser.isEmpty) {
      return const BottomNavigationBarItem(
        icon: Icon(Icons.login),
        label: 'Auth',
      );
    }

    return const BottomNavigationBarItem(
      icon: Icon(Icons.logout),
      label: 'Logout',
    );
  }

  @override
  Widget build(BuildContext context) {

    final Map<int, Object> tabScreens = {
      0: const AuctionScreen(),
      1: currentUser.isEmpty ? SignInScreen() : Container(),
    };

    Widget activeScreen = const AuctionScreen();
    activeScreen = tabScreens[_selectedIndex] as Widget;

    return Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Welcome ${state.user.givenNames}', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black)),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (state.status == AuthStatus.unauthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          child: activeScreen,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedTab,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Auctions',
            ),
            _authNavigationBartItem(currentUser),
          ],
        ));
  }
}
