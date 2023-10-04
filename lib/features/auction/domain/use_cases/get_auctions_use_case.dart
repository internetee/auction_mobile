import 'package:fpdart/fpdart.dart';

import '../entities/auction.dart';
import '../repositories/auction_repository.dart';

class GetAuctionUseCse {
  final AuctionRepository _auctionRepository;

  GetAuctionUseCse(this._auctionRepository);

  Future<Either<Exception, List<Auction>>> call() async {
    return await _auctionRepository.getAuctions();
  }
}
