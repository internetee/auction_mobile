import 'package:equatable/equatable.dart';

class Auction extends Equatable {
  final String uuid;
  final String domainName;
  final String? startsAt;
  final String? endsAt;

  const Auction({
    required this.uuid,
    required this.domainName,
    this.startsAt, this.endsAt
  });

  @override
  List<Object?> get props => [uuid, domainName, startsAt, endsAt];
}
