import { IGeoFence, NewGeoFence } from './geo-fence.model';

export const sampleWithRequiredData: IGeoFence = {
  id: 16091,
  safeZones: 'haze till calmly',
};

export const sampleWithPartialData: IGeoFence = {
  id: 1529,
  safeZones: 'innovate downright',
};

export const sampleWithFullData: IGeoFence = {
  id: 5718,
  safeZones: 'upliftingly bah archaeology',
};

export const sampleWithNewData: NewGeoFence = {
  safeZones: 'discontinue creamy',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
