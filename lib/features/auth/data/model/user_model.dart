import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

class UserModel extends Equatable {
  final String uuid;
  final String email;
  final String givenNames;
  final String surname;
  final String? mobilePhone;
  final String? locale;

  String? tempTokenStore;

  UserModel({
    required this.uuid,
    required this.email,
    required this.givenNames,
    required this.surname,
    this.mobilePhone, this.locale, this.tempTokenStore,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uuid: json['uuid'] as String,
      email: json['email'] as String,
      givenNames: json['given_names'] as String,
      surname: json['surname'] as String,
      mobilePhone: json['mobile_phone'] as String?,
      locale: json['locale'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'email': email,
      'given_names': givenNames,
      'surname': surname,
      'mobile_phone': mobilePhone,
      'locale': locale,
    };
  }

  User toEntity() {
    return User(uuid: uuid, email: email, givenNames: givenNames, surname: surname, mobilePhone: mobilePhone, locale: locale, tempTokenStore: tempTokenStore);
  }

  @override
  List<Object?> get props => [uuid, email, givenNames, surname, mobilePhone, locale, tempTokenStore];
}