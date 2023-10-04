import 'package:equatable/equatable.dart';

import '../../domain/entities/auth_user.dart';

class AuthUserModel extends Equatable {
  final String uuid;
  final String email;
  final String givenName;
  final String surname;

  const AuthUserModel({
    required this.uuid,
    required this.email,
    required this.givenName,
    required this.surname,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      uuid: json['uuid'] as String,
      email: json['email'] as String,
      givenName: json['givenName'] as String,
      surname: json['surname'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'email': email,
      'givenName': givenName,
      'surname': surname,
    };
  }

  AuthUser toEntity() {
    return AuthUser(uuid: uuid, email: email, givenName: givenName, surname: surname);
  }

  @override
  List<Object?> get props => [uuid, email, givenName, surname];
}
