import { ITongueTwister, NewTongueTwister } from './tongue-twister.model';

export const sampleWithRequiredData: ITongueTwister = {
  id: 24419,
  text: 'prioritize provided unless',
  language: 'recent',
};

export const sampleWithPartialData: ITongueTwister = {
  id: 28265,
  text: 'alliance',
  language: 'valiantly ouch',
};

export const sampleWithFullData: ITongueTwister = {
  id: 13964,
  text: 'that unlike',
  language: 'give goat',
  difficultyLevel: 12175,
};

export const sampleWithNewData: NewTongueTwister = {
  text: 'equally divine',
  language: 'since linear that',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
