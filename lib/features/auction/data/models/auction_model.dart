import 'package:auction_mobile/features/auction/domain/entities/auction.dart';
import 'package:equatable/equatable.dart';

class AuctionModel extends Equatable {
  final String uuid;
  final String domainName;
  final String? startsAt;
  final String? endsAt;
  final double? highestBid;
  final String? highestBidder;
  final String? type;

  const AuctionModel({
    required this.uuid,
    required this.domainName,
    this.startsAt,
    this.endsAt,
    this.highestBid,
    this.highestBidder,
    this.type,
  });

  factory AuctionModel.fromJson(Map<String, dynamic> json) {
    print(json);

    return AuctionModel(
      uuid: json['id'],
      domainName: json['domain_name'],
      startsAt: json['starts_at'],
      endsAt: json['ends_at'] == 'null' ? null : json['ends_at'],
      highestBid: json['highest_bid'] == 'null' ? null : json['highest_bid'],
      highestBidder: json['highest_bidder'] == 'null' ? null : json['highest_bidder'],
      type: json['auction_type'] == 'null' ? null : json['auction_type'],
    );
  }

  Auction toEntity() {
    return Auction(
      uuid: uuid,
      domainName: domainName,
      startsAt: startsAt,
      endsAt: endsAt,
      highestBid: highestBid,
      highestBidder: highestBidder,
      type: type,
    );
  }

  @override
  List<Object?> get props => [uuid, domainName, startsAt, endsAt, highestBid, highestBidder, type];
}
