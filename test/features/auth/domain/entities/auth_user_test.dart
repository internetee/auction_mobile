
import 'package:auction_mobile/features/domain/entities/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('empty AuthUser has correct default values', () {
    expect(AuthUser.empty.uuid, '');
    expect(AuthUser.empty.email, '');
    expect(AuthUser.empty.givenName, '');
    expect(AuthUser.empty.surname, '');
  });

  test('two AuthUser with the same values are equal', () {
    const user1 = AuthUser(uuid: 'uuid', email: 'email', givenName: 'givenName', surname: 'surname');
    const user2 = AuthUser(uuid: 'uuid', email: 'email', givenName: 'givenName', surname: 'surname');

    expect(user1, equals(user2));
  });

  test('two AuthUser with the different values are not equal', () {
    const user1 = AuthUser(uuid: 'uuid1', email: 'email', givenName: 'givenName', surname: 'surname');
    const user2 = AuthUser(uuid: 'uuid2', email: 'email', givenName: 'givenName', surname: 'surname');

    expect(user1, isNot(equals(user2)));
  });

  test('props returns correct properties', () {
    const user = AuthUser(uuid: 'uuid', email: 'email', givenName: 'givenName', surname: 'surname');
    expect(user.props, equals(['uuid', 'email', 'givenName', 'surname']));
  });
}
