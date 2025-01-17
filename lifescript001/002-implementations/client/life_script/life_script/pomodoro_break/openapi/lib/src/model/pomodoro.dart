//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pomodoro.g.dart';

/// Pomodoro
///
/// Properties:
/// * [id] 
/// * [workDuration] 
/// * [breakDuration] 
@BuiltValue()
abstract class Pomodoro implements Built<Pomodoro, PomodoroBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'workDuration')
  int? get workDuration;

  @BuiltValueField(wireName: r'breakDuration')
  int? get breakDuration;

  Pomodoro._();

  factory Pomodoro([void updates(PomodoroBuilder b)]) = _$Pomodoro;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PomodoroBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Pomodoro> get serializer => _$PomodoroSerializer();
}

class _$PomodoroSerializer implements PrimitiveSerializer<Pomodoro> {
  @override
  final Iterable<Type> types = const [Pomodoro, _$Pomodoro];

  @override
  final String wireName = r'Pomodoro';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Pomodoro object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.workDuration != null) {
      yield r'workDuration';
      yield serializers.serialize(
        object.workDuration,
        specifiedType: const FullType(int),
      );
    }
    if (object.breakDuration != null) {
      yield r'breakDuration';
      yield serializers.serialize(
        object.breakDuration,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Pomodoro object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PomodoroBuilder result,
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
        case r'workDuration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.workDuration = valueDes;
          break;
        case r'breakDuration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.breakDuration = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Pomodoro deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PomodoroBuilder();
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

