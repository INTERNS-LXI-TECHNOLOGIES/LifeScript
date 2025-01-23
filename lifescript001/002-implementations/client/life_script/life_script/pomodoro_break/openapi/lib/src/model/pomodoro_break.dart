//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pomodoro_break.g.dart';

/// PomodoroBreak
///
/// Properties:
/// * [id] 
/// * [totalWorkingHour] 
/// * [dailyDurationOfWork] 
/// * [splitBreakDuration] 
/// * [breakDuration] 
/// * [completedBreaks] 
/// * [dateOfPomodoro] 
/// * [timeOfPomodoroCreation] 
/// * [notificationForBreak] 
/// * [finalMessage] 
@BuiltValue()
abstract class PomodoroBreak implements Built<PomodoroBreak, PomodoroBreakBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'totalWorkingHour')
  int? get totalWorkingHour;

  @BuiltValueField(wireName: r'dailyDurationOfWork')
  int? get dailyDurationOfWork;

  @BuiltValueField(wireName: r'splitBreakDuration')
  int? get splitBreakDuration;

  @BuiltValueField(wireName: r'breakDuration')
  int? get breakDuration;

  @BuiltValueField(wireName: r'completedBreaks')
  int? get completedBreaks;

  @BuiltValueField(wireName: r'dateOfPomodoro')
  DateTime? get dateOfPomodoro;

  @BuiltValueField(wireName: r'timeOfPomodoroCreation')
  DateTime? get timeOfPomodoroCreation;

  @BuiltValueField(wireName: r'notificationForBreak')
  bool? get notificationForBreak;

  @BuiltValueField(wireName: r'finalMessage')
  String? get finalMessage;

  PomodoroBreak._();

  factory PomodoroBreak([void updates(PomodoroBreakBuilder b)]) = _$PomodoroBreak;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PomodoroBreakBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PomodoroBreak> get serializer => _$PomodoroBreakSerializer();
}

class _$PomodoroBreakSerializer implements PrimitiveSerializer<PomodoroBreak> {
  @override
  final Iterable<Type> types = const [PomodoroBreak, _$PomodoroBreak];

  @override
  final String wireName = r'PomodoroBreak';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PomodoroBreak object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalWorkingHour != null) {
      yield r'totalWorkingHour';
      yield serializers.serialize(
        object.totalWorkingHour,
        specifiedType: const FullType(int),
      );
    }
    if (object.dailyDurationOfWork != null) {
      yield r'dailyDurationOfWork';
      yield serializers.serialize(
        object.dailyDurationOfWork,
        specifiedType: const FullType(int),
      );
    }
    if (object.splitBreakDuration != null) {
      yield r'splitBreakDuration';
      yield serializers.serialize(
        object.splitBreakDuration,
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
    if (object.completedBreaks != null) {
      yield r'completedBreaks';
      yield serializers.serialize(
        object.completedBreaks,
        specifiedType: const FullType(int),
      );
    }
    if (object.dateOfPomodoro != null) {
      yield r'dateOfPomodoro';
      yield serializers.serialize(
        object.dateOfPomodoro,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.timeOfPomodoroCreation != null) {
      yield r'timeOfPomodoroCreation';
      yield serializers.serialize(
        object.timeOfPomodoroCreation,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.notificationForBreak != null) {
      yield r'notificationForBreak';
      yield serializers.serialize(
        object.notificationForBreak,
        specifiedType: const FullType(bool),
      );
    }
    if (object.finalMessage != null) {
      yield r'finalMessage';
      yield serializers.serialize(
        object.finalMessage,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PomodoroBreak object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PomodoroBreakBuilder result,
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
        case r'totalWorkingHour':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalWorkingHour = valueDes;
          break;
        case r'dailyDurationOfWork':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.dailyDurationOfWork = valueDes;
          break;
        case r'splitBreakDuration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.splitBreakDuration = valueDes;
          break;
        case r'breakDuration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.breakDuration = valueDes;
          break;
        case r'completedBreaks':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.completedBreaks = valueDes;
          break;
        case r'dateOfPomodoro':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.dateOfPomodoro = valueDes;
          break;
        case r'timeOfPomodoroCreation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.timeOfPomodoroCreation = valueDes;
          break;
        case r'notificationForBreak':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.notificationForBreak = valueDes;
          break;
        case r'finalMessage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.finalMessage = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PomodoroBreak deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PomodoroBreakBuilder();
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

