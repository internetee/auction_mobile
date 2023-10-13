import 'package:auction_mobile/features/auction/domain/use_cases/get_auctions_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/auction.dart';

part 'auction_event.dart';
part 'auction_state.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  final GetAuctionUseCse _getAuctionUseCse;

  AuctionBloc({
    required GetAuctionUseCse getAuctionUseCse,
  })  : _getAuctionUseCse = getAuctionUseCse,
        super(AuctionState()){
          on<GetAuctionsEvent>(_getAuctions);
        }

  void _getAuctions(GetAuctionsEvent event, Emitter<AuctionState> emit) async {
    final result = await _getAuctionUseCse();
    result.fold(
      (exception) {
        emit(state.copyWith(status: AuctionStatus.failure));
      },
      (auctions) {
        emit(
          state.copyWith(
            status: AuctionStatus.success,
            auctions: auctions,
          ),
        );
      },
    );
  }
}
