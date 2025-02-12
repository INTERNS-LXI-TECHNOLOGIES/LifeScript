import { ITeacher, NewTeacher } from './teacher.model';

export const sampleWithRequiredData: ITeacher = {
  id: 9510,
  name: 'preclude unselfish legal',
  school: 'train mentor',
};

export const sampleWithPartialData: ITeacher = {
  id: 28138,
  name: 'hence before gently',
  school: 'outrageous',
};

export const sampleWithFullData: ITeacher = {
  id: 30957,
  name: 'lest consequently',
  school: 'crank because',
};

export const sampleWithNewData: NewTeacher = {
  name: 'since painfully or',
  school: 'propound make',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
