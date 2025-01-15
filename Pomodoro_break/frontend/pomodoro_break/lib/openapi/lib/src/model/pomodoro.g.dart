// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Pomodoro extends Pomodoro {
  @override
  final int? id;
  @override
  final int? workDuration;
  @override
  final int? breakDuration;

  factory _$Pomodoro([void Function(PomodoroBuilder)? updates]) =>
      (new PomodoroBuilder()..update(updates))._build();

  _$Pomodoro._({this.id, this.workDuration, this.breakDuration}) : super._();

  @override
  Pomodoro rebuild(void Function(PomodoroBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PomodoroBuilder toBuilder() => new PomodoroBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Pomodoro &&
        id == other.id &&
        workDuration == other.workDuration &&
        breakDuration == other.breakDuration;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, workDuration.hashCode);
    _$hash = $jc(_$hash, breakDuration.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Pomodoro')
          ..add('id', id)
          ..add('workDuration', workDuration)
          ..add('breakDuration', breakDuration))
        .toString();
  }
}

class PomodoroBuilder implements Builder<Pomodoro, PomodoroBuilder> {
  _$Pomodoro? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _workDuration;
  int? get workDuration => _$this._workDuration;
  set workDuration(int? workDuration) => _$this._workDuration = workDuration;

  int? _breakDuration;
  int? get breakDuration => _$this._breakDuration;
  set breakDuration(int? breakDuration) =>
      _$this._breakDuration = breakDuration;

  PomodoroBuilder() {
    Pomodoro._defaults(this);
  }

  PomodoroBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _workDuration = $v.workDuration;
      _breakDuration = $v.breakDuration;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Pomodoro other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Pomodoro;
  }

  @override
  void update(void Function(PomodoroBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Pomodoro build() => _build();

  _$Pomodoro _build() {
    final _$result = _$v ??
        new _$Pomodoro._(
            id: id, workDuration: workDuration, breakDuration: breakDuration);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
