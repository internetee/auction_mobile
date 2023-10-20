part of 'offer_bloc.dart';

abstract class OfferEvent extends Equatable {
  const OfferEvent();

  @override
  List<Object> get props => [];
}

class GetOffersEvent extends OfferEvent {
  final String authToken;

  GetOffersEvent({required this.authToken});
}

