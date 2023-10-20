import 'package:fpdart/fpdart.dart';

import '../entities/offer.dart';
import '../repositories/offer_repository.dart';

class GetOffersUseCase {
  final OfferRepository offerRepository;

  GetOffersUseCase({required this.offerRepository });

  Future<Either<Exception, List<Offer>>> call(String authToken) async {
    return await offerRepository.getOffers(authToken);
  }
}
