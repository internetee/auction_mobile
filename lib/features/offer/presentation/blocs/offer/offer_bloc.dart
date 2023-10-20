import 'package:auction_mobile/features/offer/domain/use_cases/get_offers_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/offer.dart';

part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  final GetOffersUseCase _getOffersUseCase;

  OfferBloc({required GetOffersUseCase getOffersUseCase}) : _getOffersUseCase = getOffersUseCase, 
  super(OfferState()) {
    on<GetOffersEvent>(_onGetOffersEvent);
  }

  void _onGetOffersEvent(GetOffersEvent event, Emitter<OfferState> emit) async {
    final result = await _getOffersUseCase(event.authToken);
    result.fold(
      (exception) { 
        emit(state.copyWith(status: OfferStatus.error, errorMessage: exception.toString())); 
      }, 
    (offers)  { 
      emit(state.copyWith(offers: offers, status: OfferStatus.loaded)); 
    });
  }
}
