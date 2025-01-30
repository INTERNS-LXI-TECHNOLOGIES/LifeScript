import { IUser } from './user.model';

export const sampleWithRequiredData: IUser = {
  id: 13634,
  login: 'geez',
};

export const sampleWithPartialData: IUser = {
  id: 31968,
  login: 'twin infantilize oval',
};

export const sampleWithFullData: IUser = {
  id: 19749,
  login: 'wealthy athwart',
};
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
