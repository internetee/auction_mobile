import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  final String uuid;
  final int auctionId;
  final int userId;
  final int cents;
  final String createdAt;
  final String updatedAt;
  final int billingProfileId;
  final String updatedBy;
  final String username;

  const Offer({
    required this.uuid,
    required this.auctionId,
    required this.userId,
    required this.cents,
    required this.createdAt,
    required this.updatedAt,
    required this.billingProfileId,
    required this.updatedBy,
    required this.username,
  });

  static const Offer empty =
      Offer(uuid: '', auctionId: -1, userId: -1, cents: -1, createdAt: '', updatedAt: '', billingProfileId: -1, updatedBy: '', username: '');

  bool get isEmpty => this == Offer.empty;

  @override
  List<Object?> get props => [uuid, auctionId, userId, cents, createdAt, updatedAt, billingProfileId, updatedBy, username];
}
