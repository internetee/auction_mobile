part of 'websocket_cubit.dart';

abstract class WebsocketState extends Equatable {
  const WebsocketState();

  @override
  List<Object?> get props => [];
}

class WebsocketInitial extends WebsocketState {}

class WebsocketConnected extends WebsocketState {}

class WebsocketDataReceived extends WebsocketState {
  final dynamic data; // Или более конкретный тип данных

  const WebsocketDataReceived(this.data);

  @override
  List<Object?> get props => [data];
}

class WebsocketError extends WebsocketState {
  final String message;

  const WebsocketError(this.message);

  @override
  List<Object?> get props => [message];
}

class WebsocketDisconnected extends WebsocketState {}
