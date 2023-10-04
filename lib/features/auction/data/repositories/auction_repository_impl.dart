import 'package:auction_mobile/features/auction/data/models/auction_model.dart';
import 'package:auction_mobile/features/auction/domain/entities/auction.dart';
import 'package:auction_mobile/features/auction/domain/repositories/auction_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../datasource/auction_remote_data_source.dart';

class AuctionRepositoryImpl implements AuctionRepository {
  final AuctionRemoteDataSource auctionRemoteDataSource;

  AuctionRepositoryImpl({required this.auctionRemoteDataSource});

  @override
  Future<Either<Exception, List<Auction>>> getAuctions() async {
    try {
      List<Auction> auctionEntities = [];
      List<AuctionModel> auctions = await auctionRemoteDataSource.getAuctions();

      for (var auction in auctions) {
        auctionEntities.add(auction.toEntity());
      }

      return Right(auctionEntities);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
