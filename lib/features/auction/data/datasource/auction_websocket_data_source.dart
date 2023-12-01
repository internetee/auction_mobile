import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:http/http.dart' as http;

abstract class AuctionWebsocketDataSource {
  void connect();
  void disconnect();
  Stream<dynamic> get stream;
}

class AuctionWebsocketDataSourceImpl implements AuctionWebsocketDataSource {
  final String _baseUrl = dotenv.env['WEBSOCKET_DEVELOPMENT_BASE_URL'] ?? 'ws://localhost:3000/cable';
  final String _httpBaseUrl = dotenv.env['DEVELOPMENT_BASE_URL'] ?? 'http://localhost:3000';
  WebSocketChannel? _channel;

@override
  void connect() async {
    final url = Uri.parse('$_httpBaseUrl/api/stream_name');
    final response = await http.get(url);
    final signedStreamName = json.decode(response.body)['signed_stream_name'];

    _channel = WebSocketChannel.connect(Uri.parse(_baseUrl));

    final String identifier = jsonEncode({
      "channel": "AuctionsApiChannel",
      "signed_stream_name": signedStreamName
    });
    final Map<String, dynamic> subscriptionData = {
      "command": "subscribe",
      "identifier": identifier,
    };
    _channel!.sink.add(jsonEncode(subscriptionData));
  }

  @override
  void disconnect() {
    _channel?.sink.close();
  }

  @override
  Stream<dynamic> get stream => _channel?.stream.asBroadcastStream() ?? const Stream.empty();
}
