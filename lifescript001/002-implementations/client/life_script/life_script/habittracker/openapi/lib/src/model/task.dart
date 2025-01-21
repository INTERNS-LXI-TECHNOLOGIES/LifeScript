//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:habittracker_openapi/src/model/habit_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task.g.dart';

/// Task
///
/// Properties:
/// * [id] 
/// * [completed] 
/// * [habit] 
@BuiltValue()
abstract class Task implements Built<Task, TaskBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'completed')
  bool? get completed;

  @BuiltValueField(wireName: r'habit')
  HabitEntity? get habit;

  Task._();

  factory Task([void updates(TaskBuilder b)]) = _$Task;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaskBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Task> get serializer => _$TaskSerializer();
}

class _$TaskSerializer implements PrimitiveSerializer<Task> {
  @override
  final Iterable<Type> types = const [Task, _$Task];

  @override
  final String wireName = r'Task';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Task object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.completed != null) {
      yield r'completed';
      yield serializers.serialize(
        object.completed,
        specifiedType: const FullType(bool),
      );
    }
    if (object.habit != null) {
      yield r'habit';
      yield serializers.serialize(
        object.habit,
        specifiedType: const FullType(HabitEntity),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Task object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TaskBuilder result,
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
        case r'completed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.completed = valueDes;
          break;
        case r'habit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HabitEntity),
          ) as HabitEntity;
          result.habit.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Task deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaskBuilder();
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

