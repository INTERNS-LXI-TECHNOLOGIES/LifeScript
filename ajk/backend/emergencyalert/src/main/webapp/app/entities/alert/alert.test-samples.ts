import dayjs from 'dayjs/esm';

import { IAlert, NewAlert } from './alert.model';

export const sampleWithRequiredData: IAlert = {
  id: 5277,
  latitude: 23579.31,
  longitude: 4196.36,
  timestamp: dayjs('2025-02-11T21:34'),
  deviceId: 'so provided',
  status: 'brr deceivingly handle',
};

export const sampleWithPartialData: IAlert = {
  id: 9629,
  latitude: 18160.05,
  longitude: 28854.79,
  timestamp: dayjs('2025-02-11T15:23'),
  deviceId: 'an pish phooey',
  status: 'amidst',
};

export const sampleWithFullData: IAlert = {
  id: 22495,
  latitude: 3493.75,
  longitude: 8098.68,
  timestamp: dayjs('2025-02-12T06:37'),
  deviceId: 'beside house',
  status: 'softly',
};

export const sampleWithNewData: NewAlert = {
  latitude: 10112.09,
  longitude: 26579.2,
  timestamp: dayjs('2025-02-11T14:59'),
  deviceId: 'meaningfully wherever destock',
  status: 'before',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
