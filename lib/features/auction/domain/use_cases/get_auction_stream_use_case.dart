import 'package:auction_mobile/core/usecases/params/no_params.dart';
import 'package:auction_mobile/features/auction/domain/entities/auction.dart';
import 'package:auction_mobile/features/auction/domain/repositories/auction_repository.dart';

abstract class WebsocketUseCase<Type, Params> {
  Future<Stream<Type>> call(Params params);
}

class GetAuctionStreamUseCase extends WebsocketUseCase<Auction, NoParams> {
  final AuctionRepository repository;

  GetAuctionStreamUseCase(this.repository);

  @override
  Future<Stream<Auction>> call(NoParams params) async {
    return repository.getAuctionStream();
  }
}
