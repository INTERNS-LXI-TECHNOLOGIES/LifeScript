import dayjs from 'dayjs/esm';

import { IDailyJournal, NewDailyJournal } from './daily-journal.model';

export const sampleWithRequiredData: IDailyJournal = {
  id: 31254,
  title: 'rainbow indeed furiously',
  content: 'for',
  date: dayjs('2025-01-20'),
};

export const sampleWithPartialData: IDailyJournal = {
  id: 23508,
  title: 'gracious',
  content: 'fantastic haze blah',
  date: dayjs('2025-01-20'),
};

export const sampleWithFullData: IDailyJournal = {
  id: 30522,
  title: 'asphyxiate scarily unfolded',
  content: 'gosh',
  date: dayjs('2025-01-21'),
};

export const sampleWithNewData: NewDailyJournal = {
  title: 'ack',
  content: 'manufacturer',
  date: dayjs('2025-01-20'),
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
