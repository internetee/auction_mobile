import '../models/auction_model.dart';

abstract class AuctionRemoteDataSource {
  Future<List<AuctionModel>> getAuctions();
  // Future<AuctionModel> getAuction(String id);
  // Future<AuctionModel> createAuction(AuctionModel auction);
  // Future<AuctionModel> updateAuction(AuctionModel auction);
  // Future<AuctionModel> deleteAuction(String id);
}