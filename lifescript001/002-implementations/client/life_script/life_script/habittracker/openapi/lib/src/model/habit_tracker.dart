//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'habit_tracker.g.dart';

/// HabitTracker
///
/// Properties:
/// * [id] 
/// * [habitId] 
/// * [habitName] 
/// * [description] 
/// * [startDate] 
/// * [endDate] 
@BuiltValue()
abstract class HabitTracker implements Built<HabitTracker, HabitTrackerBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'habitId')
  int? get habitId;

  @BuiltValueField(wireName: r'habitName')
  String? get habitName;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'startDate')
  String? get startDate;

  @BuiltValueField(wireName: r'endDate')
  String? get endDate;

  HabitTracker._();

  factory HabitTracker([void updates(HabitTrackerBuilder b)]) = _$HabitTracker;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HabitTrackerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HabitTracker> get serializer => _$HabitTrackerSerializer();
}

class _$HabitTrackerSerializer implements PrimitiveSerializer<HabitTracker> {
  @override
  final Iterable<Type> types = const [HabitTracker, _$HabitTracker];

  @override
  final String wireName = r'HabitTracker';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HabitTracker object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.habitId != null) {
      yield r'habitId';
      yield serializers.serialize(
        object.habitId,
        specifiedType: const FullType(int),
      );
    }
    if (object.habitName != null) {
      yield r'habitName';
      yield serializers.serialize(
        object.habitName,
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
    if (object.startDate != null) {
      yield r'startDate';
      yield serializers.serialize(
        object.startDate,
        specifiedType: const FullType(String),
      );
    }
    if (object.endDate != null) {
      yield r'endDate';
      yield serializers.serialize(
        object.endDate,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HabitTracker object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HabitTrackerBuilder result,
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
        case r'habitId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.habitId = valueDes;
          break;
        case r'habitName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.habitName = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'startDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.startDate = valueDes;
          break;
        case r'endDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.endDate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HabitTracker deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HabitTrackerBuilder();
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

