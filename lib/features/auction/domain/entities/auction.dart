import 'package:equatable/equatable.dart';

class Auction extends Equatable {
  final String uuid;
  final String domainName;

  const Auction({
    required this.uuid,
    required this.domainName,
  });

  @override
  List<Object> get props => [uuid, domainName];
}
