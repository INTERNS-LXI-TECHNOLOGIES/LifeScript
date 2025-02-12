import { IChild, NewChild } from './child.model';

export const sampleWithRequiredData: IChild = {
  id: 24949,
  name: 'navigate which',
  age: 3692,
};

export const sampleWithPartialData: IChild = {
  id: 30953,
  name: 'dreamily glider',
  age: 5752,
  emergencyContact: 'depart',
};

export const sampleWithFullData: IChild = {
  id: 2481,
  name: 'supposing',
  age: 19816,
  emergencyContact: 'below during',
};

export const sampleWithNewData: NewChild = {
  name: 'boohoo surprisingly fat',
  age: 16714,
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
