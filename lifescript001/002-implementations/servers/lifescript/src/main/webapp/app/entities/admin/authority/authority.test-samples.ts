import { IAuthority, NewAuthority } from './authority.model';

export const sampleWithRequiredData: IAuthority = {
  name: '89eb12d6-af8b-41d7-af57-68a5976133ed',
};

export const sampleWithPartialData: IAuthority = {
  name: 'e305176d-e84d-4fd3-b859-c91a307dfbf8',
};

export const sampleWithFullData: IAuthority = {
  name: '0e2b4311-90b5-4a89-b6d8-25bde8d6306c',
};

export const sampleWithNewData: NewAuthority = {
  name: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
