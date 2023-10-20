part of 'offer_bloc.dart';

enum OfferStatus { initial, loading, loaded, error }

class OfferState extends Equatable {
  final List<Offer> offers;
  final OfferStatus status;
  String? errorMessage;

  OfferState({
    this.offers = const <Offer>[],
    this.status = OfferStatus.initial,
    this.errorMessage,
  });

  OfferState copyWith({List<Offer>? offers, OfferStatus? status, String? errorMessage}) {
    return OfferState(
      offers: offers ?? this.offers,
      status: status ?? this.status,
      errorMessage: errorMessage
    );
  }

  @override
  List<Object?> get props => [offers, status, errorMessage];
}
