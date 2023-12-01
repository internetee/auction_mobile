import 'dart:convert';

import 'package:auction_mobile/features/auction/data/datasource/auction_websocket_data_source.dart';
import 'package:auction_mobile/features/auction/data/models/auction_model.dart';
import 'package:auction_mobile/features/auction/domain/entities/auction.dart';
import 'package:auction_mobile/features/auction/domain/repositories/auction_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../datasource/auction_remote_data_source.dart';

class AuctionRepositoryImpl implements AuctionRepository {
  final AuctionRemoteDataSource auctionRemoteDataSource;
  final AuctionWebsocketDataSource auctionWebsocketDataSource;

  AuctionRepositoryImpl({required this.auctionRemoteDataSource, required this.auctionWebsocketDataSource});

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

  @override
  Stream<Auction> getAuctionStream() {
    auctionWebsocketDataSource.connect();

    print('-------- ?');
    print(auctionWebsocketDataSource.stream);
    print('-------- ?');

    return auctionWebsocketDataSource.stream.map((data) {
      var jsonData = json.decode(data);

      print('-------- ?');
      print(jsonData);
      print('-------- ?');

      return AuctionModel.fromJson(jsonData).toEntity();
    }).asBroadcastStream();
  }
}
