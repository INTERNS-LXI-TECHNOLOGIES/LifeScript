import { ITwisterPractice, NewTwisterPractice } from './twister-practice.model';

export const sampleWithRequiredData: ITwisterPractice = {
  id: 24633,
};

export const sampleWithPartialData: ITwisterPractice = {
  id: 4403,
};

export const sampleWithFullData: ITwisterPractice = {
  id: 8134,
  score: 11457,
  timesPracticed: 2758,
  corrections: 'successfully',
};

export const sampleWithNewData: NewTwisterPractice = {
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
