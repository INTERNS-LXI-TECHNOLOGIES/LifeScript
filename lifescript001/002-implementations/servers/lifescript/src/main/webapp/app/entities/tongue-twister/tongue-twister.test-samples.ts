import { ITongueTwister, NewTongueTwister } from './tongue-twister.model';

export const sampleWithRequiredData: ITongueTwister = {
  id: 12892,
  text: 'tambour ick ululate',
  language: 'wiggly',
};

export const sampleWithPartialData: ITongueTwister = {
  id: 29601,
  text: 'yowza',
  language: 'positively a sadly',
  difficultyLevel: 8137,
};

export const sampleWithFullData: ITongueTwister = {
  id: 16087,
  text: 'phooey which nearly',
  language: 'rarely',
  difficultyLevel: 18833,
};

export const sampleWithNewData: NewTongueTwister = {
  text: 'until',
  language: 'jaggedly',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
