// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Goal extends Goal {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final bool? completed;

  factory _$Goal([void Function(GoalBuilder)? updates]) =>
      (new GoalBuilder()..update(updates))._build();

  _$Goal._({this.id, this.title, this.description, this.completed}) : super._();

  @override
  Goal rebuild(void Function(GoalBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GoalBuilder toBuilder() => new GoalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Goal &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        completed == other.completed;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, completed.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Goal')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('completed', completed))
        .toString();
  }
}

class GoalBuilder implements Builder<Goal, GoalBuilder> {
  _$Goal? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _completed;
  bool? get completed => _$this._completed;
  set completed(bool? completed) => _$this._completed = completed;

  GoalBuilder() {
    Goal._defaults(this);
  }

  GoalBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _completed = $v.completed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Goal other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Goal;
  }

  @override
  void update(void Function(GoalBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Goal build() => _build();

  _$Goal _build() {
    final _$result = _$v ??
        new _$Goal._(
          id: id,
          title: title,
          description: description,
          completed: completed,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
