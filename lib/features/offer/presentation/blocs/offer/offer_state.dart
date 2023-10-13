part of 'offer_bloc.dart';

sealed class OfferState extends Equatable {
  const OfferState();
  
  @override
  List<Object> get props => [];
}

final class OfferInitial extends OfferState {}
