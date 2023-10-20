import 'package:equatable/equatable.dart';

import '../../domain/entities/auth_user.dart';

class AuthUserModel extends Equatable {
  final String uuid;
  final String email;
  final String givenName;
  final String surname;
  final String? mobilePhone;
  final String? locale;

  String? tempTokenStore;

  AuthUserModel({
    required this.uuid,
    required this.email,
    required this.givenName,
    required this.surname,
    this.mobilePhone, this.locale, this.tempTokenStore,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      uuid: json['uuid'] as String,
      email: json['email'] as String,
      givenName: json['given_name'] as String,
      surname: json['surname'] as String,
      mobilePhone: json['mobile_phone'] as String?,
      locale: json['locale'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'email': email,
      'given_name': givenName,
      'surname': surname,
      'mobile_phone': mobilePhone,
      'locale': locale,
    };
  }

  AuthUser toEntity() {
    return AuthUser(uuid: uuid, email: email, givenName: givenName, surname: surname, mobilePhone: mobilePhone, locale: locale, tempTokenStore: tempTokenStore);
  }

  @override
  List<Object?> get props => [uuid, email, givenName, surname, mobilePhone, locale, tempTokenStore];
}
