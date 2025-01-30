import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for UserProfileResourceApi
void main() {
  final instance = Openapi().getUserProfileResourceApi();

  group(UserProfileResourceApi, () {
    //Future<UserProfile> createUserProfile(UserProfile userProfile) async
    test('test createUserProfile', () async {
      // TODO
    });

    //Future deleteUserProfile(int id) async
    test('test deleteUserProfile', () async {
      // TODO
    });

    //Future<BuiltList<UserProfile>> getAllUserProfilesAsStream({ bool eagerload }) async
    test('test getAllUserProfilesAsStream', () async {
      // TODO
    });

    //Future<UserProfile> getUserProfile(int id) async
    test('test getUserProfile', () async {
      // TODO
    });

    //Future<UserProfile> partialUpdateUserProfile(int id, UserProfile userProfile) async
    test('test partialUpdateUserProfile', () async {
      // TODO
    });

    //Future<UserProfile> updateUserProfile(int id, UserProfile userProfile) async
    test('test updateUserProfile', () async {
      // TODO
    });

  });
}
