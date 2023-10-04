import 'package:auction_mobile/features/data/models/auth_user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_user_model_test.mocks.dart';

@GenerateMocks([AuthUserModel])
void main() {
  late MockAuthUserModel mockUser;

  setUp(() {
    mockUser = MockAuthUserModel();

    when(mockUser.uuid).thenReturn('testId');
    when(mockUser.email).thenReturn('test@test.com');
    when(mockUser.givenName).thenReturn('Test');
    when(mockUser.surname).thenReturn('User');
  });

  const uuid = 'testId';
  const email = 'test@test.com';
  const givenName = 'Test';
  const surname = 'User';

  const authUserModel = AuthUserModel(
    uuid: uuid,
    email: email,
    givenName: givenName,
    surname: surname,
  );

  group('AuthUserModel', () {
    test('properties are correctly assigned on creation', () {
      expect(authUserModel.uuid, equals(uuid));
      expect(authUserModel.email, equals(email));
      expect(authUserModel.givenName, equals(givenName));
      expect(authUserModel.surname, equals(surname));
    });

    test('creates AuthUserModel from FirebaseUser', () {
      final authUserModel = AuthUserModel.fromJson(mockUser.toJson());

      expect(authUserModel.uuid, equals(mockUser.uuid));
      expect(authUserModel.email, equals(mockUser.email));
      expect(authUserModel.givenName, equals(mockUser.givenName));
      expect(authUserModel.surname, equals(mockUser.surname));
    });

    test('converts to entity correctly', () {
      final authUser = authUserModel.toEntity();

      expect(authUser.uuid, equals(uuid));
      expect(authUser.email, equals(email));
      expect(authUser.givenName, equals(givenName));
      expect(authUser.surname, equals(surname));
    });

    test('get props returns a list with all properties', () {
      final props = authUserModel.props;

      expect(props, containsAll([uuid, email, givenName, surname]));
    });

    test('handles null values in firebase user correctly', () {
      when(mockUser.email).thenReturn('');
      when(mockUser.givenName).thenReturn('');
      when(mockUser.surname).thenReturn('');

      final authUserModel = AuthUserModel.fromJson(mockUser.toJson());

      expect(authUserModel.email, equals(''));
      expect(authUserModel.givenName, isNull);
      expect(authUserModel.surname, isNull);
    });
  });
}
