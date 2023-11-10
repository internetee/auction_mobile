import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exception.dart';
import '../model/user_model.dart';
import 'dart:convert';

const chachedUser = 'CACHED_USER';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel> getUser();
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel user) {
    final jsonUser = jsonEncode(user.toJson());

    return sharedPreferences.setString(chachedUser, jsonUser);
  }

  @override
  Future<UserModel> getUser() {
    final jsonString = sharedPreferences.getString(chachedUser);

    if (jsonString == null || jsonString.isEmpty) {
      throw CacheException();
    }

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return Future.value(UserModel.fromJson(jsonMap));
  }

  @override
  Future<void> clearUser() {
    return sharedPreferences.remove(chachedUser);
  }
}
