import 'package:auction_mobile/features/offer/data/models/offer_model.dart';
import 'package:auction_mobile/features/offer/domain/entities/offer.dart';
import 'package:auction_mobile/features/offer/domain/repositories/offer_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../datasource/offer_remote_data_source.dart';

class OfferRepositoryImpl extends OfferRepository {
  OfferRemoteDataSource offerRemoteDataSource;

  OfferRepositoryImpl({required this.offerRemoteDataSource});

  @override
  Future<Either<Exception, List<Offer>>> getOffers(String authToken) async {
    try {
      List<OfferModel> offerList = await offerRemoteDataSource.getOffers(authToken);

      return Right(offerList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
