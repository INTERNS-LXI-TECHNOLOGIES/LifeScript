//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'media_content.g.dart';

/// MediaContent
///
/// Properties:
/// * [id] 
/// * [text] 
/// * [uploadDateTime] 
/// * [language] 
/// * [difficultyLevel] 
/// * [textAudio] 
/// * [textAudioContentType] 
@BuiltValue()
abstract class MediaContent implements Built<MediaContent, MediaContentBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'text')
  String? get text;

  @BuiltValueField(wireName: r'uploadDateTime')
  DateTime? get uploadDateTime;

  @BuiltValueField(wireName: r'language')
  String? get language;

  @BuiltValueField(wireName: r'difficultyLevel')
  int? get difficultyLevel;

  @BuiltValueField(wireName: r'textAudio')
  String? get textAudio;

  @BuiltValueField(wireName: r'textAudioContentType')
  String? get textAudioContentType;

  MediaContent._();

  factory MediaContent([void updates(MediaContentBuilder b)]) = _$MediaContent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MediaContentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MediaContent> get serializer => _$MediaContentSerializer();

  Object? get idToken => null;
}

class _$MediaContentSerializer implements PrimitiveSerializer<MediaContent> {
  @override
  final Iterable<Type> types = const [MediaContent, _$MediaContent];

  @override
  final String wireName = r'MediaContent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MediaContent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.text != null) {
      yield r'text';
      yield serializers.serialize(
        object.text,
        specifiedType: const FullType(String),
      );
    }
    if (object.uploadDateTime != null) {
      yield r'uploadDateTime';
      yield serializers.serialize(
        object.uploadDateTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.language != null) {
      yield r'language';
      yield serializers.serialize(
        object.language,
        specifiedType: const FullType(String),
      );
    }
    if (object.difficultyLevel != null) {
      yield r'difficultyLevel';
      yield serializers.serialize(
        object.difficultyLevel,
        specifiedType: const FullType(int),
      );
    }
    if (object.textAudio != null) {
      yield r'textAudio';
      yield serializers.serialize(
        object.textAudio,
        specifiedType: const FullType(String),
      );
    }
    if (object.textAudioContentType != null) {
      yield r'textAudioContentType';
      yield serializers.serialize(
        object.textAudioContentType,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MediaContent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MediaContentBuilder result,
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
        case r'text':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.text = valueDes;
          break;
        case r'uploadDateTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.uploadDateTime = valueDes;
          break;
        case r'language':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.language = valueDes;
          break;
        case r'difficultyLevel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.difficultyLevel = valueDes;
          break;
        case r'textAudio':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.textAudio = valueDes;
          break;
        case r'textAudioContentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.textAudioContentType = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MediaContent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MediaContentBuilder();
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

