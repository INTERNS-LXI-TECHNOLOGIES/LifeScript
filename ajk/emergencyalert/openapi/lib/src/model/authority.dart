//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'authority.g.dart';

/// Authority
///
/// Properties:
/// * [name] 
@BuiltValue()
abstract class Authority implements Built<Authority, AuthorityBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  Authority._();

  factory Authority([void updates(AuthorityBuilder b)]) = _$Authority;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthorityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Authority> get serializer => _$AuthoritySerializer();
}

class _$AuthoritySerializer implements PrimitiveSerializer<Authority> {
  @override
  final Iterable<Type> types = const [Authority, _$Authority];

  @override
  final String wireName = r'Authority';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Authority object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Authority object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthorityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Authority deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthorityBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

