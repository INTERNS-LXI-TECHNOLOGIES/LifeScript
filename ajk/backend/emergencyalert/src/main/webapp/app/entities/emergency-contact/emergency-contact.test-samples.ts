import { IEmergencyContact, NewEmergencyContact } from './emergency-contact.model';

export const sampleWithRequiredData: IEmergencyContact = {
  id: 3446,
  name: 'mechanically consequently ha',
  type: 'shocked throughout',
  phoneNumber: 'preheat',
};

export const sampleWithPartialData: IEmergencyContact = {
  id: 28543,
  name: 'yahoo appropriate',
  type: 'oof really',
  phoneNumber: 'stake colligate',
};

export const sampleWithFullData: IEmergencyContact = {
  id: 21863,
  name: 'when alert likewise',
  type: 'blue mean off',
  phoneNumber: 'minus hm book',
};

export const sampleWithNewData: NewEmergencyContact = {
  name: 'though',
  type: 'needily tomorrow gee',
  phoneNumber: 'chow gah nab',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
