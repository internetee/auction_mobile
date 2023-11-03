import 'package:auction_mobile/configs/locator_service.dart';
import 'package:auction_mobile/features/auction/domain/repositories/auction_repository.dart';
import 'package:auction_mobile/features/auction/domain/use_cases/get_auctions_use_case.dart';
import 'package:auction_mobile/features/auction/presentation/blocs/auction/auction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuctionScreen extends StatelessWidget {
  const AuctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuctionBloc>(
        // create: (context) => AuctionBloc(getAuctionUseCse: GetAuctionUseCse(auctionRepository: context.read<AuctionRepository>()))..add(GetAuctionsEvent()),
        create: (context) => sl<AuctionBloc>()..add(GetAuctionsEvent()),
        child: const AuctionView());
  }
}

class AuctionView extends StatelessWidget {
  const AuctionView({super.key});

  bool _isSignedIn(BuildContext context) {
    // print('-----');
    // print(context.read<AppBloc>().state.authUser);
    // print('-----');

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Auctions'),
        ),
        body: BlocBuilder<AuctionBloc, AuctionState>(
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
                    // _isSignedIn(context) ? signInButton(context) : Container(),
                    signInButton(context),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                    TextButton(
                        onPressed: () {
                          context.goNamed('sign-up');
                        },
                        child: Text('Sign Up')),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                    TextButton(
                        onPressed: () {
                          context.goNamed('offers');
                        },
                        child: Text('Offers')),
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
