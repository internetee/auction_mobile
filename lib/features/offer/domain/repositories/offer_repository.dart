import 'package:auction_mobile/features/offer/domain/entities/offer.dart';
import 'package:fpdart/fpdart.dart';

abstract class OfferRepository {
  Future<Either<Exception, List<Offer>>> getOffers(String authToken);
}
