//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:communication_openapi/src/date_serializer.dart';
import 'package:communication_openapi/src/model/date.dart';

import 'package:communication_openapi/src/model/admin_user_dto.dart';
import 'package:communication_openapi/src/model/authority.dart';
import 'package:communication_openapi/src/model/jwt_token.dart';
import 'package:communication_openapi/src/model/key_and_password_vm.dart';
import 'package:communication_openapi/src/model/login_vm.dart';
import 'package:communication_openapi/src/model/managed_user_vm.dart';
import 'package:communication_openapi/src/model/media_content.dart';
import 'package:communication_openapi/src/model/password_change_dto.dart';
import 'package:communication_openapi/src/model/twister_practice.dart';
import 'package:communication_openapi/src/model/user.dart';
import 'package:communication_openapi/src/model/user_dto.dart';
import 'package:communication_openapi/src/model/user_profile.dart';

part 'serializers.g.dart';

@SerializersFor([
  AdminUserDTO,
  Authority,
  JWTToken,
  KeyAndPasswordVM,
  LoginVM,
  ManagedUserVM,
  MediaContent,
  PasswordChangeDTO,
  TwisterPractice,
  User,
  UserDTO,
  UserProfile,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(UserProfile)]),
        () => ListBuilder<UserProfile>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AdminUserDTO)]),
        () => ListBuilder<AdminUserDTO>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(MediaContent)]),
        () => ListBuilder<MediaContent>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(String)]),
        () => ListBuilder<String>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(UserDTO)]),
        () => ListBuilder<UserDTO>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Authority)]),
        () => ListBuilder<Authority>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TwisterPractice)]),
        () => ListBuilder<TwisterPractice>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
