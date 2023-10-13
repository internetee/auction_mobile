import '../models/auth_user_model.dart';
import 'auth_remote_data_source.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // /sessions/sign_in(

  final String _baseUrl = dotenv.env['DEVELOPMENT_BASE_URL'] ?? 'http://localhost:3000';
  final http.Client _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<AuthUserModel?> signInWithEmailAndPassword({required String email, required String password}) async {
    // final String url = '$_baseUrl/sessions/sign_in';
    final url = Uri.parse('$_baseUrl/sessions/sign_in');
    final response = await _client.post(
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


      print('User comes ---- >');
      print(responseBody);
      print('-----?>');

      final authUser = AuthUserModel.fromJson(responseBody);
      final token = response.headers['authorization'];
      authUser.tempTokenStore = token ?? '';



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
  Future<AuthUserModel?> signUpUserWithEmailAndPassword({required String email, required String password}) {
    // TODO: implement signUpUserWithEmailAndPassword
    throw UnimplementedError();
  }

  // @override
  // // TODO: implement user
  // Stream<AuthUserModel?> get user => throw UnimplementedError();

  static final fakeUser = AuthUserModel(
    uuid: 'fake-user-id',
    email: 'fake-user-email',
    givenName: 'fake-user-name',
    surname: 'fake-user-name',
  );

  @override
  Stream<AuthUserModel?> get user {
    return Stream.value(fakeUser);
  }

  // @override
  // Future<AuthUserModel> signUpUserWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   return fakeUser;
  // }

  // @override
  // Future<AuthUserModel> signInWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   return fakeUser;
  // }

  // @override
  // Future<void> signOut() async {
  //   throw UnimplementedError();
  // }
}
