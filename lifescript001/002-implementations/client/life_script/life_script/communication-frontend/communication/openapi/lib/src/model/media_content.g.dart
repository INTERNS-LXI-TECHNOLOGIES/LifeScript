// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_content.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MediaContent extends MediaContent {
  @override
  final int? id;
  @override
  final String? text;
  @override
  final DateTime? uploadDateTime;
  @override
  final String? language;
  @override
  final int? difficultyLevel;
  @override
  final String? textAudio;
  @override
  final String? textAudioContentType;

  factory _$MediaContent([void Function(MediaContentBuilder)? updates]) =>
      (new MediaContentBuilder()..update(updates))._build();

  _$MediaContent._(
      {this.id,
      this.text,
      this.uploadDateTime,
      this.language,
      this.difficultyLevel,
      this.textAudio,
      this.textAudioContentType})
      : super._();

  @override
  MediaContent rebuild(void Function(MediaContentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MediaContentBuilder toBuilder() => new MediaContentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MediaContent &&
        id == other.id &&
        text == other.text &&
        uploadDateTime == other.uploadDateTime &&
        language == other.language &&
        difficultyLevel == other.difficultyLevel &&
        textAudio == other.textAudio &&
        textAudioContentType == other.textAudioContentType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, uploadDateTime.hashCode);
    _$hash = $jc(_$hash, language.hashCode);
    _$hash = $jc(_$hash, difficultyLevel.hashCode);
    _$hash = $jc(_$hash, textAudio.hashCode);
    _$hash = $jc(_$hash, textAudioContentType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MediaContent')
          ..add('id', id)
          ..add('text', text)
          ..add('uploadDateTime', uploadDateTime)
          ..add('language', language)
          ..add('difficultyLevel', difficultyLevel)
          ..add('textAudio', textAudio)
          ..add('textAudioContentType', textAudioContentType))
        .toString();
  }
}

class MediaContentBuilder
    implements Builder<MediaContent, MediaContentBuilder> {
  _$MediaContent? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  DateTime? _uploadDateTime;
  DateTime? get uploadDateTime => _$this._uploadDateTime;
  set uploadDateTime(DateTime? uploadDateTime) =>
      _$this._uploadDateTime = uploadDateTime;

  String? _language;
  String? get language => _$this._language;
  set language(String? language) => _$this._language = language;

  int? _difficultyLevel;
  int? get difficultyLevel => _$this._difficultyLevel;
  set difficultyLevel(int? difficultyLevel) =>
      _$this._difficultyLevel = difficultyLevel;

  String? _textAudio;
  String? get textAudio => _$this._textAudio;
  set textAudio(String? textAudio) => _$this._textAudio = textAudio;

  String? _textAudioContentType;
  String? get textAudioContentType => _$this._textAudioContentType;
  set textAudioContentType(String? textAudioContentType) =>
      _$this._textAudioContentType = textAudioContentType;

  MediaContentBuilder() {
    MediaContent._defaults(this);
  }

  MediaContentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _text = $v.text;
      _uploadDateTime = $v.uploadDateTime;
      _language = $v.language;
      _difficultyLevel = $v.difficultyLevel;
      _textAudio = $v.textAudio;
      _textAudioContentType = $v.textAudioContentType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MediaContent other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MediaContent;
  }

  @override
  void update(void Function(MediaContentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MediaContent build() => _build();

  _$MediaContent _build() {
    final _$result = _$v ??
        new _$MediaContent._(
          id: id,
          text: text,
          uploadDateTime: uploadDateTime,
          language: language,
          difficultyLevel: difficultyLevel,
          textAudio: textAudio,
          textAudioContentType: textAudioContentType,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
