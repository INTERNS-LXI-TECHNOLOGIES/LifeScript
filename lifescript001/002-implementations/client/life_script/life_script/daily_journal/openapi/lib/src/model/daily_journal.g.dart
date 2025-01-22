// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_journal.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DailyJournal extends DailyJournal {
  @override
  final int? id;
  @override
  final String title;
  @override
  final String content;
  @override
  final Date date;

  factory _$DailyJournal([void Function(DailyJournalBuilder)? updates]) =>
      (new DailyJournalBuilder()..update(updates))._build();

  _$DailyJournal._(
      {this.id, required this.title, required this.content, required this.date})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(title, r'DailyJournal', 'title');
    BuiltValueNullFieldError.checkNotNull(content, r'DailyJournal', 'content');
    BuiltValueNullFieldError.checkNotNull(date, r'DailyJournal', 'date');
  }

  @override
  DailyJournal rebuild(void Function(DailyJournalBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DailyJournalBuilder toBuilder() => new DailyJournalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DailyJournal &&
        id == other.id &&
        title == other.title &&
        content == other.content &&
        date == other.date;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DailyJournal')
          ..add('id', id)
          ..add('title', title)
          ..add('content', content)
          ..add('date', date))
        .toString();
  }
}

class DailyJournalBuilder
    implements Builder<DailyJournal, DailyJournalBuilder> {
  _$DailyJournal? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  DailyJournalBuilder() {
    DailyJournal._defaults(this);
  }

  DailyJournalBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _content = $v.content;
      _date = $v.date;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DailyJournal other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DailyJournal;
  }

  @override
  void update(void Function(DailyJournalBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DailyJournal build() => _build();

  _$DailyJournal _build() {
    final _$result = _$v ??
        new _$DailyJournal._(
          id: id,
          title: BuiltValueNullFieldError.checkNotNull(
              title, r'DailyJournal', 'title'),
          content: BuiltValueNullFieldError.checkNotNull(
              content, r'DailyJournal', 'content'),
          date: BuiltValueNullFieldError.checkNotNull(
              date, r'DailyJournal', 'date'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
