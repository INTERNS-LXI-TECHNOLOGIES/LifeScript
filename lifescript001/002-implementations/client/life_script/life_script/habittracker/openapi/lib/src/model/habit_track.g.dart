// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_track.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HabitTrack extends HabitTrack {
  @override
  final int? id;
  @override
  final int? habitId;
  @override
  final String? habitName;
  @override
  final String? description;
  @override
  final String? category;
  @override
  final String? startDate;
  @override
  final String? endDate;

  factory _$HabitTrack([void Function(HabitTrackBuilder)? updates]) =>
      (new HabitTrackBuilder()..update(updates))._build();

  _$HabitTrack._(
      {this.id,
      this.habitId,
      this.habitName,
      this.description,
      this.category,
      this.startDate,
      this.endDate})
      : super._();

  @override
  HabitTrack rebuild(void Function(HabitTrackBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HabitTrackBuilder toBuilder() => new HabitTrackBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HabitTrack &&
        id == other.id &&
        habitId == other.habitId &&
        habitName == other.habitName &&
        description == other.description &&
        category == other.category &&
        startDate == other.startDate &&
        endDate == other.endDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, habitId.hashCode);
    _$hash = $jc(_$hash, habitName.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HabitTrack')
          ..add('id', id)
          ..add('habitId', habitId)
          ..add('habitName', habitName)
          ..add('description', description)
          ..add('category', category)
          ..add('startDate', startDate)
          ..add('endDate', endDate))
        .toString();
  }
}

class HabitTrackBuilder implements Builder<HabitTrack, HabitTrackBuilder> {
  _$HabitTrack? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _habitId;
  int? get habitId => _$this._habitId;
  set habitId(int? habitId) => _$this._habitId = habitId;

  String? _habitName;
  String? get habitName => _$this._habitName;
  set habitName(String? habitName) => _$this._habitName = habitName;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _startDate;
  String? get startDate => _$this._startDate;
  set startDate(String? startDate) => _$this._startDate = startDate;

  String? _endDate;
  String? get endDate => _$this._endDate;
  set endDate(String? endDate) => _$this._endDate = endDate;

  HabitTrackBuilder() {
    HabitTrack._defaults(this);
  }

  HabitTrackBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _habitId = $v.habitId;
      _habitName = $v.habitName;
      _description = $v.description;
      _category = $v.category;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HabitTrack other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HabitTrack;
  }

  @override
  void update(void Function(HabitTrackBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HabitTrack build() => _build();

  _$HabitTrack _build() {
    final _$result = _$v ??
        new _$HabitTrack._(
          id: id,
          habitId: habitId,
          habitName: habitName,
          description: description,
          category: category,
          startDate: startDate,
          endDate: endDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
