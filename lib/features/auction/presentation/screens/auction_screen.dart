import 'package:auction_mobile/configs/locator_service.dart';
import 'package:auction_mobile/features/auction/presentation/blocs/auction/auction_bloc.dart';
import 'package:auction_mobile/features/auction/presentation/blocs/websocket/websocket_cubit.dart';
import 'package:auction_mobile/features/auction/presentation/widgets/auction_card.dart';
import 'package:auction_mobile/features/auction/presentation/widgets/hero.dart';
import 'package:auction_mobile/features/auction/presentation/widgets/inform_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Auctions'),
        ),
        body: BlocConsumer<WebsocketCubit, WebsocketState>(
          listener: (context, websocketState) {
            if (websocketState is WebsocketDataReceived) {
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
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const AuctionHero(),
                          const SizedBox(
                            height: 8,
                          ),
                          const InformCard(
                            svgPath: 'assets/images/gift.svg',
                            title: 'Submit an offer',
                            description:
                                'to the .ee domain of your choice. Depending on the domain name, the auctions take place either in the style of a blind auction or an open-bid auction',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const InformCard(
                            svgPath: 'assets/images/timer.svg',
                            title: 'Wait for an auction to end',
                            description:
                                'We will let you know about the result by email. The preferential right to register the domain name will be granted to the highest bidder.',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const InformCard(
                            svgPath: 'assets/images/card.svg',
                            title: 'Pay auction fee',
                            description:
                                'Once the fee is paid, you will receive a registration code that you can use at any accredited registrar.',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.auctions.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return AuctionCard(
                                auction: state.auctions[index],
                              );
                            },
                          ),
                        ],
                      ),
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
        ));
  }
}
