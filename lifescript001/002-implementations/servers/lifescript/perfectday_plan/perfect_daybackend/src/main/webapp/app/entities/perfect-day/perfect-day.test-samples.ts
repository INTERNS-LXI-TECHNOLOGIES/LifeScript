import dayjs from 'dayjs/esm';

import { IPerfectDay, NewPerfectDay } from './perfect-day.model';

export const sampleWithRequiredData: IPerfectDay = {
  id: 7340,
  title: 'anenst detain entwine',
  date: dayjs('2025-01-20'),
};

export const sampleWithPartialData: IPerfectDay = {
  id: 23049,
  title: 'which hm exacerbate',
  description: 'after hospitalization or',
  date: dayjs('2025-01-20'),
};

export const sampleWithFullData: IPerfectDay = {
  id: 14033,
  title: 'quietly unlawful gee',
  description: 'anenst decongestant dreamily',
  date: dayjs('2025-01-20'),
};

export const sampleWithNewData: NewPerfectDay = {
  title: 'import but',
  date: dayjs('2025-01-20'),
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
