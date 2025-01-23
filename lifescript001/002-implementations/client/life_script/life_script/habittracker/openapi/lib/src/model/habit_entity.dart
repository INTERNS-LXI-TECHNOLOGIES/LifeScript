//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'habit_entity.g.dart';

/// HabitEntity
///
/// Properties:
/// * [id] 
/// * [duration] 
/// * [habit] 
/// * [description] 
@BuiltValue()
abstract class HabitEntity implements Built<HabitEntity, HabitEntityBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'duration')
  String? get duration;

  @BuiltValueField(wireName: r'habit')
  String? get habit;

  @BuiltValueField(wireName: r'description')
  String? get description;

  HabitEntity._();

  factory HabitEntity([void updates(HabitEntityBuilder b)]) = _$HabitEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HabitEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HabitEntity> get serializer => _$HabitEntitySerializer();
}

class _$HabitEntitySerializer implements PrimitiveSerializer<HabitEntity> {
  @override
  final Iterable<Type> types = const [HabitEntity, _$HabitEntity];

  @override
  final String wireName = r'HabitEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HabitEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.duration != null) {
      yield r'duration';
      yield serializers.serialize(
        object.duration,
        specifiedType: const FullType(String),
      );
    }
    if (object.habit != null) {
      yield r'habit';
      yield serializers.serialize(
        object.habit,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HabitEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HabitEntityBuilder result,
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
        case r'duration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.duration = valueDes;
          break;
        case r'habit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.habit = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HabitEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HabitEntityBuilder();
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

