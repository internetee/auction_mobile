import 'dart:convert';

import 'package:auction_mobile/features/auction/data/datasource/auction_remote_data_source.dart';
import 'package:auction_mobile/features/auction/data/models/auction_model.dart';

import 'package:http/http.dart' as http;

class AuctionRemoteDataSourceImpl implements AuctionRemoteDataSource {
  final String _baseUrl = "#";
  final http.Client _client;

  AuctionRemoteDataSourceImpl(this._client);

  Future<Map<String, String>> _setHeader() async {
    String token = 'mock-token';

    return {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
  }

  @override
  Future<List<AuctionModel>> getAuctions() async {
    final url = Uri.parse('$_baseUrl/auctions');
    final response = await _client.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<AuctionModel> auctions = [];

      for (var auction in responseBody['auctions']) {
        auctions.add(AuctionModel.fromJson(auction));
      }

      return auctions;
    } else {
      return Future.error(Exception('Failed to load interests data'));
    }
  }
}
