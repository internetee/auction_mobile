import '../models/offer_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class OfferRemoteDataSource {
  Future<List<OfferModel>> getOffers(String authToken);
}

class OfferRemoteDataSourceImpl extends OfferRemoteDataSource {
  final String _baseUrl = dotenv.env['DEVELOPMENT_BASE_URL'] ?? 'http://localhost:3000';
  final http.Client _client;

  OfferRemoteDataSourceImpl(this._client);
  
  @override
  Future<List<OfferModel>> getOffers(String authToken) async {
    final url = Uri.parse('$_baseUrl/offers');
    final response = await _client.get(url, headers: _headers(authToken));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final offers = (responseBody as List).map((e) => OfferModel.fromJson(e)).toList();
      return offers;
    } else {
      throw Exception(response.body);
    }
  }

  Map<String, String>? _headers(String authToken) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $authToken'
    };
  }
}
