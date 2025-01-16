// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Task extends Task {
  @override
  final int? id;
  @override
  final bool? completed;
  @override
  final HabitEntity? habit;

  factory _$Task([void Function(TaskBuilder)? updates]) =>
      (new TaskBuilder()..update(updates))._build();

  _$Task._({this.id, this.completed, this.habit}) : super._();

  @override
  Task rebuild(void Function(TaskBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskBuilder toBuilder() => new TaskBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Task &&
        id == other.id &&
        completed == other.completed &&
        habit == other.habit;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, completed.hashCode);
    _$hash = $jc(_$hash, habit.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Task')
          ..add('id', id)
          ..add('completed', completed)
          ..add('habit', habit))
        .toString();
  }
}

class TaskBuilder implements Builder<Task, TaskBuilder> {
  _$Task? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  bool? _completed;
  bool? get completed => _$this._completed;
  set completed(bool? completed) => _$this._completed = completed;

  HabitEntityBuilder? _habit;
  HabitEntityBuilder get habit => _$this._habit ??= new HabitEntityBuilder();
  set habit(HabitEntityBuilder? habit) => _$this._habit = habit;

  TaskBuilder() {
    Task._defaults(this);
  }

  TaskBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _completed = $v.completed;
      _habit = $v.habit?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Task other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Task;
  }

  @override
  void update(void Function(TaskBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Task build() => _build();

  _$Task _build() {
    _$Task _$result;
    try {
      _$result = _$v ??
          new _$Task._(id: id, completed: completed, habit: _habit?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'habit';
        _habit?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Task', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
