import '../model/user_model.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AuthRemoteDataSource {
  // Stream<AuthUserModel?> get user;

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> signUpUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.client });

  final String _baseUrl = dotenv.env['DEVELOPMENT_BASE_URL'] ?? 'http://localhost:3000';
  final http.Client client;

  @override
  Future<UserModel> signInWithEmailAndPassword({required String email, required String password}) async {
    final url = Uri.parse('$_baseUrl/sessions/sign_in');
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      body: json.encode({
        'user': {
          'email': email,
          'password': password,
        }
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = json.decode(response.body);

      print(responseBody);

      final authUser = UserModel.fromJson(responseBody);
      final token = response.headers['authorization'];
      authUser.tempTokenStore = token ?? '';

      print('authUser: ${authUser.tempTokenStore}');

      return authUser;
    } else {
      return Future.error(Exception('Failed to load user data'));
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> signUpUserWithEmailAndPassword({required String email, required String password}) {
    // TODO: implement signUpUserWithEmailAndPassword
    throw UnimplementedError();
  }
}
