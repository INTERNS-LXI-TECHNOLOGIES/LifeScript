import dayjs from 'dayjs/esm';

export interface IPomodoroBreak {
  id: number;
  totalWorkingHour?: number | null;
  dailyDurationOfWork?: number | null;
  splitBreakDuration?: number | null;
  breakDuration?: number | null;
  completedBreaks?: number | null;
  dateOfPomodoro?: dayjs.Dayjs | null;
  timeOfPomodoroCreation?: dayjs.Dayjs | null;
  notificationForBreak?: boolean | null;
  finalMessage?: string | null;
}

export type NewPomodoroBreak = Omit<IPomodoroBreak, 'id'> & { id: null };
