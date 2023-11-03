import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message});

  String toString() => 'ServerFailure { message: $message }';
}

class CacheFailure extends Failure {
  final String? message;

  CacheFailure({this.message});

  @override
  List<Object?> get props => [message];
}

class ValidationFailure extends Failure {
  final String message;

  ValidationFailure({required this.message});

  @override
  String toString() {
    return 'Validation Error: $message';
  }
}

