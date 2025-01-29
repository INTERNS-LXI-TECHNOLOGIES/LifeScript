// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twister_practice.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TwisterPractice extends TwisterPractice {
  @override
  final int? id;
  @override
  final int? score;
  @override
  final int? timesPracticed;
  @override
  final String? corrections;
  @override
  final int? userProfileId;
  @override
  final int? mediaContentId;

  factory _$TwisterPractice([void Function(TwisterPracticeBuilder)? updates]) =>
      (new TwisterPracticeBuilder()..update(updates))._build();

  _$TwisterPractice._(
      {this.id,
      this.score,
      this.timesPracticed,
      this.corrections,
      this.userProfileId,
      this.mediaContentId})
      : super._();

  @override
  TwisterPractice rebuild(void Function(TwisterPracticeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TwisterPracticeBuilder toBuilder() =>
      new TwisterPracticeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TwisterPractice &&
        id == other.id &&
        score == other.score &&
        timesPracticed == other.timesPracticed &&
        corrections == other.corrections &&
        userProfileId == other.userProfileId &&
        mediaContentId == other.mediaContentId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, timesPracticed.hashCode);
    _$hash = $jc(_$hash, corrections.hashCode);
    _$hash = $jc(_$hash, userProfileId.hashCode);
    _$hash = $jc(_$hash, mediaContentId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TwisterPractice')
          ..add('id', id)
          ..add('score', score)
          ..add('timesPracticed', timesPracticed)
          ..add('corrections', corrections)
          ..add('userProfileId', userProfileId)
          ..add('mediaContentId', mediaContentId))
        .toString();
  }
}

class TwisterPracticeBuilder
    implements Builder<TwisterPractice, TwisterPracticeBuilder> {
  _$TwisterPractice? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _score;
  int? get score => _$this._score;
  set score(int? score) => _$this._score = score;

  int? _timesPracticed;
  int? get timesPracticed => _$this._timesPracticed;
  set timesPracticed(int? timesPracticed) =>
      _$this._timesPracticed = timesPracticed;

  String? _corrections;
  String? get corrections => _$this._corrections;
  set corrections(String? corrections) => _$this._corrections = corrections;

  int? _userProfileId;
  int? get userProfileId => _$this._userProfileId;
  set userProfileId(int? userProfileId) =>
      _$this._userProfileId = userProfileId;

  int? _mediaContentId;
  int? get mediaContentId => _$this._mediaContentId;
  set mediaContentId(int? mediaContentId) =>
      _$this._mediaContentId = mediaContentId;

  TwisterPracticeBuilder() {
    TwisterPractice._defaults(this);
  }

  TwisterPracticeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _score = $v.score;
      _timesPracticed = $v.timesPracticed;
      _corrections = $v.corrections;
      _userProfileId = $v.userProfileId;
      _mediaContentId = $v.mediaContentId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TwisterPractice other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TwisterPractice;
  }

  @override
  void update(void Function(TwisterPracticeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TwisterPractice build() => _build();

  _$TwisterPractice _build() {
    final _$result = _$v ??
        new _$TwisterPractice._(
          id: id,
          score: score,
          timesPracticed: timesPracticed,
          corrections: corrections,
          userProfileId: userProfileId,
          mediaContentId: mediaContentId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
