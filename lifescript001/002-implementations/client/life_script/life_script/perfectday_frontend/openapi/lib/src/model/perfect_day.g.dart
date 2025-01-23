// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfect_day.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PerfectDay extends PerfectDay {
  @override
  final int? id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final Date date;

  factory _$PerfectDay([void Function(PerfectDayBuilder)? updates]) =>
      (new PerfectDayBuilder()..update(updates))._build();

  _$PerfectDay._(
      {this.id, required this.title, this.description, required this.date})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(title, r'PerfectDay', 'title');
    BuiltValueNullFieldError.checkNotNull(date, r'PerfectDay', 'date');
  }

  @override
  PerfectDay rebuild(void Function(PerfectDayBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PerfectDayBuilder toBuilder() => new PerfectDayBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PerfectDay &&
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
    return (newBuiltValueToStringHelper(r'PerfectDay')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('date', date))
        .toString();
  }
}

class PerfectDayBuilder implements Builder<PerfectDay, PerfectDayBuilder> {
  _$PerfectDay? _$v;

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

  PerfectDayBuilder() {
    PerfectDay._defaults(this);
  }

  PerfectDayBuilder get _$this {
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
  void replace(PerfectDay other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PerfectDay;
  }

  @override
  void update(void Function(PerfectDayBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PerfectDay build() => _build();

  _$PerfectDay _build() {
    final _$result = _$v ??
        new _$PerfectDay._(
          id: id,
          title: BuiltValueNullFieldError.checkNotNull(
              title, r'PerfectDay', 'title'),
          description: description,
          date: BuiltValueNullFieldError.checkNotNull(
              date, r'PerfectDay', 'date'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
