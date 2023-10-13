import 'dart:async';
import 'dart:convert';

import 'package:auction_mobile/features/auction/data/datasource/auction_remote_data_source.dart';
import 'package:auction_mobile/features/auction/data/models/auction_model.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuctionRemoteDataSourceImpl implements AuctionRemoteDataSource {
  final String _baseUrl = dotenv.env['DEVELOPMENT_BASE_URL'] ?? 'http://localhost:3000';
  final http.Client _client;

  AuctionRemoteDataSourceImpl(this._client);

  Future<Map<String, String>> _setHeader() async {
    String token = 'mock-token';

    return {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
  }

  @override
  Future<List<AuctionModel>> getAuctions() async {
    try {
      final url = Uri.parse('$_baseUrl/auctions?format=json');
      final response = await _client.get(url, headers: {'Content-Type': 'application/json'});

      print(response);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        List<AuctionModel> auctions = [];

        for (var auction in responseBody) {
          auctions.add(AuctionModel.fromJson(auction));
        }

        return auctions;
      } else {
        return Future.error(Exception('Failed to load interests data'));
      }
    } catch (error) {
      print('Error occurred: $error');
      return Future.error(Exception(error));
    }
  }
}
