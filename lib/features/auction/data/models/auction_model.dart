import 'package:auction_mobile/features/auction/domain/entities/auction.dart';
import 'package:equatable/equatable.dart';

class AuctionModel extends Equatable {
  final String uuid;
  final String domainName;
  final String? startsAt;
  final String? endsAt;

  const AuctionModel({
    required this.uuid,
    required this.domainName,
    this.startsAt, this.endsAt
  });

  factory AuctionModel.fromJson(Map<String, dynamic> json) {
    return AuctionModel(
      uuid: json['id'],
      domainName: json['domain_name'],
      startsAt: json['starts_at'],
      endsAt: json['ends_at'],
    );
  }

  Auction toEntity() {
    return Auction(
      uuid: uuid,
      domainName: domainName,
      startsAt: startsAt,
      endsAt: endsAt,
    );
  }

  @override
  List<Object?> get props => [uuid, domainName, startsAt, endsAt];
}