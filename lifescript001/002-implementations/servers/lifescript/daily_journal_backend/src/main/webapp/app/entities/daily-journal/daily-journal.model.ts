import dayjs from 'dayjs/esm';

export interface IDailyJournal {
  id: number;
  title?: string | null;
  content?: string | null;
  date?: dayjs.Dayjs | null;
}

export type NewDailyJournal = Omit<IDailyJournal, 'id'> & { id: null };
