import dayjs from 'dayjs/esm';

import { IDailyJournal, NewDailyJournal } from './daily-journal.model';

export const sampleWithRequiredData: IDailyJournal = {
  id: 13705,
  title: 'cash',
  content: 'shirk pricey what',
  date: dayjs('2025-01-21'),
};

export const sampleWithPartialData: IDailyJournal = {
  id: 24116,
  title: 'selfishly',
  content: 'loudly atop past',
  date: dayjs('2025-01-20'),
};

export const sampleWithFullData: IDailyJournal = {
  id: 28774,
  title: 'whenever',
  content: 'small',
  date: dayjs('2025-01-20'),
};

export const sampleWithNewData: NewDailyJournal = {
  title: 'joyful whether',
  content: 'fifth',
  date: dayjs('2025-01-20'),
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
