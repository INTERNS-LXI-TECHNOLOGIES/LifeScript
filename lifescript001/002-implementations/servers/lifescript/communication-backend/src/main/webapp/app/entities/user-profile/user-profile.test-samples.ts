import { IUserProfile, NewUserProfile } from './user-profile.model';

export const sampleWithRequiredData: IUserProfile = {
  id: 4033,
  nickName: 'deselect ravioli fervently',
  address: 'harmful indeed supposing',
};

export const sampleWithPartialData: IUserProfile = {
  id: 2358,
  nickName: 'intrepid',
  address: 'ornery',
};

export const sampleWithFullData: IUserProfile = {
  id: 9570,
  nickName: 'folklore glisten cuddly',
  address: 'guidance second',
};

export const sampleWithNewData: NewUserProfile = {
  nickName: 'ick astride awesome',
  address: 'jealously',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
