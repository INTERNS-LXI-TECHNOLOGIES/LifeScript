// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro_break.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PomodoroBreak extends PomodoroBreak {
  @override
  final int? id;
  @override
  final int? totalWorkingHour;
  @override
  final int? dailyDurationOfWork;
  @override
  final int? splitBreakDuration;
  @override
  final int? breakDuration;
  @override
  final int? completedBreaks;
  @override
  final DateTime? dateOfPomodoro;
  @override
  final DateTime? timeOfPomodoroCreation;
  @override
  final bool? notificationForBreak;
  @override
  final String? finalMessage;

  factory _$PomodoroBreak([void Function(PomodoroBreakBuilder)? updates]) =>
      (new PomodoroBreakBuilder()..update(updates))._build();

  _$PomodoroBreak._(
      {this.id,
      this.totalWorkingHour,
      this.dailyDurationOfWork,
      this.splitBreakDuration,
      this.breakDuration,
      this.completedBreaks,
      this.dateOfPomodoro,
      this.timeOfPomodoroCreation,
      this.notificationForBreak,
      this.finalMessage})
      : super._();

  @override
  PomodoroBreak rebuild(void Function(PomodoroBreakBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PomodoroBreakBuilder toBuilder() => new PomodoroBreakBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PomodoroBreak &&
        id == other.id &&
        totalWorkingHour == other.totalWorkingHour &&
        dailyDurationOfWork == other.dailyDurationOfWork &&
        splitBreakDuration == other.splitBreakDuration &&
        breakDuration == other.breakDuration &&
        completedBreaks == other.completedBreaks &&
        dateOfPomodoro == other.dateOfPomodoro &&
        timeOfPomodoroCreation == other.timeOfPomodoroCreation &&
        notificationForBreak == other.notificationForBreak &&
        finalMessage == other.finalMessage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, totalWorkingHour.hashCode);
    _$hash = $jc(_$hash, dailyDurationOfWork.hashCode);
    _$hash = $jc(_$hash, splitBreakDuration.hashCode);
    _$hash = $jc(_$hash, breakDuration.hashCode);
    _$hash = $jc(_$hash, completedBreaks.hashCode);
    _$hash = $jc(_$hash, dateOfPomodoro.hashCode);
    _$hash = $jc(_$hash, timeOfPomodoroCreation.hashCode);
    _$hash = $jc(_$hash, notificationForBreak.hashCode);
    _$hash = $jc(_$hash, finalMessage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PomodoroBreak')
          ..add('id', id)
          ..add('totalWorkingHour', totalWorkingHour)
          ..add('dailyDurationOfWork', dailyDurationOfWork)
          ..add('splitBreakDuration', splitBreakDuration)
          ..add('breakDuration', breakDuration)
          ..add('completedBreaks', completedBreaks)
          ..add('dateOfPomodoro', dateOfPomodoro)
          ..add('timeOfPomodoroCreation', timeOfPomodoroCreation)
          ..add('notificationForBreak', notificationForBreak)
          ..add('finalMessage', finalMessage))
        .toString();
  }
}

class PomodoroBreakBuilder
    implements Builder<PomodoroBreak, PomodoroBreakBuilder> {
  _$PomodoroBreak? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _totalWorkingHour;
  int? get totalWorkingHour => _$this._totalWorkingHour;
  set totalWorkingHour(int? totalWorkingHour) =>
      _$this._totalWorkingHour = totalWorkingHour;

  int? _dailyDurationOfWork;
  int? get dailyDurationOfWork => _$this._dailyDurationOfWork;
  set dailyDurationOfWork(int? dailyDurationOfWork) =>
      _$this._dailyDurationOfWork = dailyDurationOfWork;

  int? _splitBreakDuration;
  int? get splitBreakDuration => _$this._splitBreakDuration;
  set splitBreakDuration(int? splitBreakDuration) =>
      _$this._splitBreakDuration = splitBreakDuration;

  int? _breakDuration;
  int? get breakDuration => _$this._breakDuration;
  set breakDuration(int? breakDuration) =>
      _$this._breakDuration = breakDuration;

  int? _completedBreaks;
  int? get completedBreaks => _$this._completedBreaks;
  set completedBreaks(int? completedBreaks) =>
      _$this._completedBreaks = completedBreaks;

  DateTime? _dateOfPomodoro;
  DateTime? get dateOfPomodoro => _$this._dateOfPomodoro;
  set dateOfPomodoro(DateTime? dateOfPomodoro) =>
      _$this._dateOfPomodoro = dateOfPomodoro;

  DateTime? _timeOfPomodoroCreation;
  DateTime? get timeOfPomodoroCreation => _$this._timeOfPomodoroCreation;
  set timeOfPomodoroCreation(DateTime? timeOfPomodoroCreation) =>
      _$this._timeOfPomodoroCreation = timeOfPomodoroCreation;

  bool? _notificationForBreak;
  bool? get notificationForBreak => _$this._notificationForBreak;
  set notificationForBreak(bool? notificationForBreak) =>
      _$this._notificationForBreak = notificationForBreak;

  String? _finalMessage;
  String? get finalMessage => _$this._finalMessage;
  set finalMessage(String? finalMessage) => _$this._finalMessage = finalMessage;

  PomodoroBreakBuilder() {
    PomodoroBreak._defaults(this);
  }

  PomodoroBreakBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _totalWorkingHour = $v.totalWorkingHour;
      _dailyDurationOfWork = $v.dailyDurationOfWork;
      _splitBreakDuration = $v.splitBreakDuration;
      _breakDuration = $v.breakDuration;
      _completedBreaks = $v.completedBreaks;
      _dateOfPomodoro = $v.dateOfPomodoro;
      _timeOfPomodoroCreation = $v.timeOfPomodoroCreation;
      _notificationForBreak = $v.notificationForBreak;
      _finalMessage = $v.finalMessage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PomodoroBreak other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PomodoroBreak;
  }

  @override
  void update(void Function(PomodoroBreakBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PomodoroBreak build() => _build();

  _$PomodoroBreak _build() {
    final _$result = _$v ??
        new _$PomodoroBreak._(
          id: id,
          totalWorkingHour: totalWorkingHour,
          dailyDurationOfWork: dailyDurationOfWork,
          splitBreakDuration: splitBreakDuration,
          breakDuration: breakDuration,
          completedBreaks: completedBreaks,
          dateOfPomodoro: dateOfPomodoro,
          timeOfPomodoroCreation: timeOfPomodoroCreation,
          notificationForBreak: notificationForBreak,
          finalMessage: finalMessage,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
