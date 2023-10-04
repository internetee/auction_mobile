import 'package:auction_mobile/features/auction/domain/entities/auction.dart';
import 'package:equatable/equatable.dart';

class AuctionModel extends Equatable {
  final String uuid;
  final String domainName;

  const AuctionModel({
    required this.uuid,
    required this.domainName,
  });

  factory AuctionModel.fromJson(Map<String, dynamic> json) {
    return AuctionModel(
      uuid: json['uuid'],
      domainName: json['domainName'],
    );
  }

  Auction toEntity() {
    return Auction(
      uuid: uuid,
      domainName: domainName,
    );
  }

  @override
  List<Object> get props => [uuid, domainName];
}