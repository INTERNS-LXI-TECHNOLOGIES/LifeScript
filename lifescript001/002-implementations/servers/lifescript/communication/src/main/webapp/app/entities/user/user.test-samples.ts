import { IUser } from './user.model';

export const sampleWithRequiredData: IUser = {
  id: 24814,
  login: 'fuel extremely ha',
};

export const sampleWithPartialData: IUser = {
  id: 966,
  login: 'inure however',
};

export const sampleWithFullData: IUser = {
  id: 5440,
  login: 'as athwart above',
};
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
