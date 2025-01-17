// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DayPlan extends DayPlan {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final Date? date;

  factory _$DayPlan([void Function(DayPlanBuilder)? updates]) =>
      (new DayPlanBuilder()..update(updates))._build();

  _$DayPlan._({this.id, this.title, this.description, this.date}) : super._();

  @override
  DayPlan rebuild(void Function(DayPlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DayPlanBuilder toBuilder() => new DayPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DayPlan &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        date == other.date;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DayPlan')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('date', date))
        .toString();
  }
}

class DayPlanBuilder implements Builder<DayPlan, DayPlanBuilder> {
  _$DayPlan? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  DayPlanBuilder() {
    DayPlan._defaults(this);
  }

  DayPlanBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _date = $v.date;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DayPlan other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DayPlan;
  }

  @override
  void update(void Function(DayPlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DayPlan build() => _build();

  _$DayPlan _build() {
    final _$result = _$v ??
        new _$DayPlan._(
            id: id, title: title, description: description, date: date);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
