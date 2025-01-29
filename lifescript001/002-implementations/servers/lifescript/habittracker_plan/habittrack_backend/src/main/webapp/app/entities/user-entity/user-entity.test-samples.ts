import { IUserEntity, NewUserEntity } from './user-entity.model';

export const sampleWithRequiredData: IUserEntity = {
  id: 15060,
};

export const sampleWithPartialData: IUserEntity = {
  id: 11659,
};

export const sampleWithFullData: IUserEntity = {
  id: 19980,
  userId: 14805,
  userName: 'quaintly understated',
};

export const sampleWithNewData: NewUserEntity = {
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
