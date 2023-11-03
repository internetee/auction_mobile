import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uuid;
  final String email;
  final String givenName;
  final String surname;
  final String? mobilePhone;
  final String? locale;

  final String? tempTokenStore;

  const User({required this.uuid, required this.email, required this.givenName, required this.surname, this.mobilePhone, this.locale, this.tempTokenStore});

  static const User empty = User(uuid: '', email: '', givenName: '', surname: '', mobilePhone: '', locale: '', tempTokenStore: '');

  bool get isEmpty => this == User.empty;

  @override
  List<Object?> get props => [uuid, email, givenName, surname, mobilePhone, locale, tempTokenStore];
}
