import { IBatteryStatus, NewBatteryStatus } from './battery-status.model';

export const sampleWithRequiredData: IBatteryStatus = {
  id: 4925,
  batteryLevel: 23113,
};

export const sampleWithPartialData: IBatteryStatus = {
  id: 29861,
  batteryLevel: 2399,
};

export const sampleWithFullData: IBatteryStatus = {
  id: 27112,
  batteryLevel: 12619,
};

export const sampleWithNewData: NewBatteryStatus = {
  batteryLevel: 29936,
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
