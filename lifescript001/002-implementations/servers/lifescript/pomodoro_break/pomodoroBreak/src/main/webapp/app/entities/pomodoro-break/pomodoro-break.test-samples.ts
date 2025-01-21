import dayjs from 'dayjs/esm';

import { IPomodoroBreak, NewPomodoroBreak } from './pomodoro-break.model';

export const sampleWithRequiredData: IPomodoroBreak = {
  id: 1042,
};

export const sampleWithPartialData: IPomodoroBreak = {
  id: 4700,
  totalWorkingHour: 6513,
  splitBreakDuration: 31553,
  notificationForBreak: false,
};

export const sampleWithFullData: IPomodoroBreak = {
  id: 2465,
  userName: 'corny till',
  totalWorkingHour: 23614,
  dailyDurationOfWork: 20875,
  splitBreakDuration: 14276,
  breakDuration: 12075,
  completedBreaks: 10097,
  dateOfPomodoro: dayjs('2025-01-20T18:48'),
  timeOfPomodoroCreation: dayjs('2025-01-20T17:14'),
  notificationForBreak: false,
  finalMessage: 'worriedly',
};

export const sampleWithNewData: NewPomodoroBreak = {
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
