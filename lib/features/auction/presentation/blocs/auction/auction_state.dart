part of 'auction_bloc.dart';

enum AuctionStatus { initial, loading, success, failure }

class AuctionState extends Equatable {
  final List<Auction> auctions;
  final AuctionStatus status;

  const AuctionState({
    this.auctions = const <Auction>[],
    this.status = AuctionStatus.initial,
  });

  AuctionState copyWith({
    List<Auction>? auctions,
    AuctionStatus? status,
  }) {
    return AuctionState(
      auctions: auctions ?? this.auctions,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [auctions, status];
}
