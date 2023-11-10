import 'package:auction_mobile/core/usecases/params/no_params.dart';
import 'package:auction_mobile/features/auction/domain/use_cases/get_auction_stream_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'websocket_state.dart';

class WebsocketCubit extends Cubit<WebsocketState> {
  final GetAuctionStreamUseCase getAuctionStreamUseCase;

  WebsocketCubit({required this.getAuctionStreamUseCase}) : super(WebsocketInitial());

  Future<void> fetchAuctionStream() async {
    try {
      emit(WebsocketConnected()); // Соединение установлено

      final auctionStream = await getAuctionStreamUseCase(NoParams());
      await for (final auction in auctionStream) {
        emit(WebsocketDataReceived(auction)); // Данные получены
      }
    } catch (e) {
      emit(WebsocketError(e.toString())); // Обработка ошибок
    } finally {
      emit(WebsocketDisconnected()); // Соединение закрыто
    }
  }
}
