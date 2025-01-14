// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$JournalEntry extends JournalEntry {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? content;
  @override
  final Date? date;

  factory _$JournalEntry([void Function(JournalEntryBuilder)? updates]) =>
      (new JournalEntryBuilder()..update(updates))._build();

  _$JournalEntry._({this.id, this.title, this.content, this.date}) : super._();

  @override
  JournalEntry rebuild(void Function(JournalEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  JournalEntryBuilder toBuilder() => new JournalEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is JournalEntry &&
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
    return (newBuiltValueToStringHelper(r'JournalEntry')
          ..add('id', id)
          ..add('title', title)
          ..add('content', content)
          ..add('date', date))
        .toString();
  }
}

class JournalEntryBuilder
    implements Builder<JournalEntry, JournalEntryBuilder> {
  _$JournalEntry? _$v;

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

  JournalEntryBuilder() {
    JournalEntry._defaults(this);
  }

  JournalEntryBuilder get _$this {
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
  void replace(JournalEntry other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$JournalEntry;
  }

  @override
  void update(void Function(JournalEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  JournalEntry build() => _build();

  _$JournalEntry _build() {
    final _$result = _$v ??
        new _$JournalEntry._(
            id: id, title: title, content: content, date: date);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
