//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'twister_practice.g.dart';

/// TwisterPractice
///
/// Properties:
/// * [id] 
/// * [score] 
/// * [timesPracticed] 
/// * [corrections] 
/// * [userProfileId] 
/// * [mediaContentId] 
@BuiltValue()
abstract class TwisterPractice implements Built<TwisterPractice, TwisterPracticeBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'score')
  int? get score;

  @BuiltValueField(wireName: r'timesPracticed')
  int? get timesPracticed;

  @BuiltValueField(wireName: r'corrections')
  String? get corrections;

  @BuiltValueField(wireName: r'userProfileId')
  int? get userProfileId;

  @BuiltValueField(wireName: r'mediaContentId')
  int? get mediaContentId;

  TwisterPractice._();

  factory TwisterPractice([void updates(TwisterPracticeBuilder b)]) = _$TwisterPractice;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TwisterPracticeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TwisterPractice> get serializer => _$TwisterPracticeSerializer();
}

class _$TwisterPracticeSerializer implements PrimitiveSerializer<TwisterPractice> {
  @override
  final Iterable<Type> types = const [TwisterPractice, _$TwisterPractice];

  @override
  final String wireName = r'TwisterPractice';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TwisterPractice object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.score != null) {
      yield r'score';
      yield serializers.serialize(
        object.score,
        specifiedType: const FullType(int),
      );
    }
    if (object.timesPracticed != null) {
      yield r'timesPracticed';
      yield serializers.serialize(
        object.timesPracticed,
        specifiedType: const FullType(int),
      );
    }
    if (object.corrections != null) {
      yield r'corrections';
      yield serializers.serialize(
        object.corrections,
        specifiedType: const FullType(String),
      );
    }
    if (object.userProfileId != null) {
      yield r'userProfileId';
      yield serializers.serialize(
        object.userProfileId,
        specifiedType: const FullType(int),
      );
    }
    if (object.mediaContentId != null) {
      yield r'mediaContentId';
      yield serializers.serialize(
        object.mediaContentId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TwisterPractice object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TwisterPracticeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.score = valueDes;
          break;
        case r'timesPracticed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.timesPracticed = valueDes;
          break;
        case r'corrections':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.corrections = valueDes;
          break;
        case r'userProfileId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userProfileId = valueDes;
          break;
        case r'mediaContentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.mediaContentId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TwisterPractice deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TwisterPracticeBuilder();
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

