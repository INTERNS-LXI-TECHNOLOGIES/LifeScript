import dayjs from 'dayjs/esm';

import { IPomodoroBreak, NewPomodoroBreak } from './pomodoro-break.model';

export const sampleWithRequiredData: IPomodoroBreak = {
  id: 1042,
};

export const sampleWithPartialData: IPomodoroBreak = {
  id: 30444,
  dailyDurationOfWork: 4700,
  breakDuration: 6513,
  finalMessage: 'internal remark angrily',
};

export const sampleWithFullData: IPomodoroBreak = {
  id: 2465,
  totalWorkingHour: 17497,
  dailyDurationOfWork: 31457,
  splitBreakDuration: 25373,
  breakDuration: 17504,
  completedBreaks: 31266,
  dateOfPomodoro: dayjs('2025-01-22T05:00'),
  timeOfPomodoroCreation: dayjs('2025-01-22T01:30'),
  notificationForBreak: true,
  finalMessage: 'plus',
};

export const sampleWithNewData: NewPomodoroBreak = {
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
