import 'package:fpdart/fpdart.dart';

import '../entities/auction.dart';

abstract class AuctionRepository {
  Future<Either<Exception, List<Auction>>> getAuctions();
  Stream<Auction> getAuctionStream();
}
