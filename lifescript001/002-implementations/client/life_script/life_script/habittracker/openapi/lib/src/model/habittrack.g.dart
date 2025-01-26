// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habittrack.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Habittrack extends Habittrack {
  @override
  final int? id;
  @override
  final int? habitId;
  @override
  final String? habitName;
  @override
  final String? description;
  @override
  final String? startDate;
  @override
  final String? endDate;

  factory _$Habittrack([void Function(HabittrackBuilder)? updates]) =>
      (new HabittrackBuilder()..update(updates))._build();

  _$Habittrack._(
      {this.id,
      this.habitId,
      this.habitName,
      this.description,
      this.startDate,
      this.endDate})
      : super._();

  @override
  Habittrack rebuild(void Function(HabittrackBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HabittrackBuilder toBuilder() => new HabittrackBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Habittrack &&
        id == other.id &&
        habitId == other.habitId &&
        habitName == other.habitName &&
        description == other.description &&
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
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Habittrack')
          ..add('id', id)
          ..add('habitId', habitId)
          ..add('habitName', habitName)
          ..add('description', description)
          ..add('startDate', startDate)
          ..add('endDate', endDate))
        .toString();
  }
}

class HabittrackBuilder implements Builder<Habittrack, HabittrackBuilder> {
  _$Habittrack? _$v;

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

  String? _startDate;
  String? get startDate => _$this._startDate;
  set startDate(String? startDate) => _$this._startDate = startDate;

  String? _endDate;
  String? get endDate => _$this._endDate;
  set endDate(String? endDate) => _$this._endDate = endDate;

  HabittrackBuilder() {
    Habittrack._defaults(this);
  }

  HabittrackBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _habitId = $v.habitId;
      _habitName = $v.habitName;
      _description = $v.description;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Habittrack other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Habittrack;
  }

  @override
  void update(void Function(HabittrackBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Habittrack build() => _build();

  _$Habittrack _build() {
    final _$result = _$v ??
        new _$Habittrack._(
          id: id,
          habitId: habitId,
          habitName: habitName,
          description: description,
          startDate: startDate,
          endDate: endDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
