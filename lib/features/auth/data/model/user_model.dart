import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

class UserModel extends Equatable {
  final String uuid;
  final String email;
  final String givenName;
  final String surname;
  final String? mobilePhone;
  final String? locale;

  String? tempTokenStore;

  UserModel({
    required this.uuid,
    required this.email,
    required this.givenName,
    required this.surname,
    this.mobilePhone, this.locale, this.tempTokenStore,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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

  User toEntity() {
    return User(uuid: uuid, email: email, givenName: givenName, surname: surname, mobilePhone: mobilePhone, locale: locale, tempTokenStore: tempTokenStore);
  }

  @override
  List<Object?> get props => [uuid, email, givenName, surname, mobilePhone, locale, tempTokenStore];
}