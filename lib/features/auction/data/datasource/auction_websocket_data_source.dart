import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class AuctionWebsocketDataSource {
  void connect();
  void disconnect();
  Stream<dynamic> get stream;
}

class AuctionWebsocketDataSourceImpl implements AuctionWebsocketDataSource {
  final String _baseUrl = dotenv.env['WEBSOCKET_DEVELOPMENT_BASE_URL'] ?? 'ws://localhost:3000/cable';
  WebSocketChannel? _channel;

  @override
  void connect() {
    _channel = WebSocketChannel.connect(Uri.parse(_baseUrl));
  }

  @override
  void disconnect() {
    _channel?.sink.close();
  }

  @override
  Stream<dynamic> get stream => _channel?.stream.asBroadcastStream() ?? Stream.empty();
}
