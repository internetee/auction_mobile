import 'package:equatable/equatable.dart';

import '../../domain/entities/offer.dart';

class OfferModel extends Equatable {
  final String uuid;
  final int auctionId;
  final int userId;
  final int cents;
  final String createdAt;
  final String updatedAt;
  final int billingProfileId;
  final String updatedBy;
  final String username;

  const OfferModel({
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

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      uuid: json['uuid'] as String,
      auctionId: json['auctionId'] as int,
      userId: json['userId'] as int,
      cents: json['cents'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      billingProfileId: json['billingProfileId'] as int,
      updatedBy: json['updatedBy'] as String,
      username: json['username'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'auctionId': auctionId,
      'userId': userId,
      'cents': cents,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'billingProfileId': billingProfileId,
      'updatedBy': updatedBy,
      'username': username,
    };
  }

  Offer toEntity() {
    return Offer(
        uuid: uuid,
        auctionId: auctionId,
        userId: userId,
        cents: cents,
        createdAt: createdAt,
        updatedAt: updatedAt,
        billingProfileId: billingProfileId,
        updatedBy: updatedBy,
        username: username);
  }

  @override
  List<Object?> get props => [uuid, auctionId, userId, cents, createdAt, updatedAt, billingProfileId, updatedBy, username];
}
