// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HabitEntity extends HabitEntity {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? habit;
  @override
  final String? description;

  factory _$HabitEntity([void Function(HabitEntityBuilder)? updates]) =>
      (new HabitEntityBuilder()..update(updates))._build();

  _$HabitEntity._({this.id, this.name, this.habit, this.description})
      : super._();

  @override
  HabitEntity rebuild(void Function(HabitEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HabitEntityBuilder toBuilder() => new HabitEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HabitEntity &&
        id == other.id &&
        name == other.name &&
        habit == other.habit &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, habit.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HabitEntity')
          ..add('id', id)
          ..add('name', name)
          ..add('habit', habit)
          ..add('description', description))
        .toString();
  }
}

class HabitEntityBuilder implements Builder<HabitEntity, HabitEntityBuilder> {
  _$HabitEntity? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _habit;
  String? get habit => _$this._habit;
  set habit(String? habit) => _$this._habit = habit;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  HabitEntityBuilder() {
    HabitEntity._defaults(this);
  }

  HabitEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _habit = $v.habit;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HabitEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HabitEntity;
  }

  @override
  void update(void Function(HabitEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HabitEntity build() => _build();

  _$HabitEntity _build() {
    final _$result = _$v ??
        new _$HabitEntity._(
            id: id, name: name, habit: habit, description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
