import 'package:auction_mobile/configs/locator_service.dart';
import 'package:auction_mobile/features/offer/presentation/blocs/offer/offer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/domain/entities/user.dart';
import '../../domain/repositories/offer_repository.dart';

class OffersScreen extends StatelessWidget {
  final User user;

  const OffersScreen({ super.key, required this.user });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OfferBloc>(
      // create: (context) => OfferBloc(getOffersUseCase: GetOffersUseCase(offerRepository: context.read<OfferRepository>()))..add(GetOffersEvent(authToken: authUser.tempTokenStore ?? '')),
      create: (context) => sl<OfferBloc>()..add(GetOffersEvent(authToken: user.tempTokenStore ?? '')),
      child: OffersView(),
    );
  }
}

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Offers'),
        ),
        body: BlocBuilder<OfferBloc, OfferState>(
          builder: (context, state) {
            if (state.status == OfferStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.status == OfferStatus.loaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                    TextButton(
                        onPressed: () {
                          context.goNamed('auctions');
                        },
                        child: Text('Back')),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.offers.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.offers[index].uuid),
                            subtitle: Text(state.offers[index].cents.toString()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state.status == OfferStatus.error) {
              return Container(
                  child: Center(
                child: Text(state.errorMessage ?? 'Error'),
              ));
            }

            return Container(
                child: Center(
              child: Text(state.status.toString()),
            ));
          },
        ));
  }
}
