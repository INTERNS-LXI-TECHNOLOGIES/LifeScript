import { IDemo, NewDemo } from './demo.model';

export const sampleWithRequiredData: IDemo = {
  id: 15814,
};

export const sampleWithPartialData: IDemo = {
  id: 30563,
  username: 'gracefully',
};

export const sampleWithFullData: IDemo = {
  id: 24519,
  username: 'oh before inside',
  mobileNumber: 21213,
};

export const sampleWithNewData: NewDemo = {
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
