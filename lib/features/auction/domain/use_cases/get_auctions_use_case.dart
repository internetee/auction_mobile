import 'package:fpdart/fpdart.dart';

import '../entities/auction.dart';
import '../repositories/auction_repository.dart';

class GetAuctionUseCse {
  final AuctionRepository auctionRepository;

  GetAuctionUseCse({required AuctionRepository this.auctionRepository});

  Future<Either<Exception, List<Auction>>> call() async {
    return await auctionRepository.getAuctions();
  }
}
