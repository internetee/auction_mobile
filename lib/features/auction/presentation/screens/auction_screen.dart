import 'package:auction_mobile/configs/locator_service.dart';
import 'package:auction_mobile/features/auction/presentation/blocs/auction/auction_bloc.dart';
import 'package:auction_mobile/features/auction/presentation/blocs/websocket/websocket_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/cubit/auth/auth_cubit.dart';

class AuctionScreen extends StatelessWidget {
  const AuctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuctionBloc>(create: (context) => sl<AuctionBloc>()..add(GetAuctionsEvent()), child: const AuctionView());
  }
}

class AuctionView extends StatelessWidget {
  const AuctionView({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final currentUser = authCubit.state.user;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Auctions'),
        ),
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
          child: BlocConsumer<WebsocketCubit, WebsocketState>(
            listener: (context, websocketState) {
              if (websocketState is WebsocketDataReceived) {
                // Обработайте полученные данные
                // Например, обновите список аукционов или покажите уведомление

                print('WebsocketDataReceived: ${websocketState.data}');

              }
              if (websocketState is WebsocketError) {
                print('WebsocketError: ${websocketState.message}');

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(websocketState.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return BlocBuilder<AuctionBloc, AuctionState>(
                builder: (context, state) {
                  if (state.status == AuctionStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.status == AuctionStatus.success) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          currentUser.givenNames.isEmpty ? const Text('No User') : Text(currentUser.givenNames),
                          signInButton(context),
                          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                          TextButton(
                            onPressed: () {
                              context.goNamed('sign-up');
                            },
                            child: const Text('Sign Up'),
                          ),
                          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                          TextButton(
                            onPressed: () {
                              // context.goNamed('sign-up');

                              authCubit.signOut();
                            },
                            child: const Text('Sign Out'),
                          ),
                          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                          TextButton(
                            onPressed: () {
                              context.goNamed('offers');
                            },
                            child: const Text('Offers'),
                          ),
                          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.auctions.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(state.auctions[index].uuid),
                                  subtitle: Text(state.auctions[index].domainName),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Container(
                      child: Center(
                    child: Text(state.status.toString()),
                  ));
                },
              );
            },
          ),
        ));
  }

  Widget signInButton(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
        TextButton(
            onPressed: () {
              context.goNamed('sign-in');
            },
            child: Text('Sign In')),
      ],
    );
  }
}
