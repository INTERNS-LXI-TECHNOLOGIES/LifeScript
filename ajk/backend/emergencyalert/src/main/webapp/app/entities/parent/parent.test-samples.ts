import { IParent, NewParent } from './parent.model';

export const sampleWithRequiredData: IParent = {
  id: 21038,
  name: 'retention',
  phoneNumber: 'huzzah catalyst well-made',
};

export const sampleWithPartialData: IParent = {
  id: 18742,
  name: 'injunction',
  phoneNumber: 'into',
};

export const sampleWithFullData: IParent = {
  id: 1697,
  name: 'beyond ouch breed',
  phoneNumber: 'but',
};

export const sampleWithNewData: NewParent = {
  name: 'secret tragic rightfully',
  phoneNumber: 'frantically whoa',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
