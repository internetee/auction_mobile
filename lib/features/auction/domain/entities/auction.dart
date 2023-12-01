import 'package:equatable/equatable.dart';

class Auction extends Equatable {
  final String uuid;
  final String domainName;
  final String? startsAt;
  final String? endsAt;
  final double? highestBid;
  final String? highestBidder;
  final String? type;

  const Auction({
    required this.uuid,
    required this.domainName,
    this.startsAt,
    this.endsAt,
    this.highestBid,
    this.highestBidder,
    this.type,
  });

  @override
  List<Object?> get props => [uuid, domainName, startsAt, endsAt, highestBid, highestBidder, type];
}
