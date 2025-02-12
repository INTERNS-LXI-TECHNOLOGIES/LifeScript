import dayjs from 'dayjs/esm';

import { IGpsEntry, NewGpsEntry } from './gps-entry.model';

export const sampleWithRequiredData: IGpsEntry = {
  id: 14836,
  latitude: 8001.36,
  longitude: 11969.13,
  timestamp: dayjs('2025-02-11T12:49'),
  deviceId: 'orientate',
  status: 'famously hence',
};

export const sampleWithPartialData: IGpsEntry = {
  id: 24683,
  latitude: 29691.94,
  longitude: 11282.12,
  timestamp: dayjs('2025-02-11T16:22'),
  deviceId: 'stratify provided',
  status: 'wiggly rekindle widow',
};

export const sampleWithFullData: IGpsEntry = {
  id: 20853,
  latitude: 2785.72,
  longitude: 15952.1,
  timestamp: dayjs('2025-02-11T12:20'),
  deviceId: 'or showboat',
  status: 'scared',
};

export const sampleWithNewData: NewGpsEntry = {
  latitude: 21663.84,
  longitude: 17624.56,
  timestamp: dayjs('2025-02-12T04:24'),
  deviceId: 'phew ravioli idolized',
  status: 'towards roughly',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
