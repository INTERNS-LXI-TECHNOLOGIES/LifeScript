import dayjs from 'dayjs/esm';

import { IMediaContent, NewMediaContent } from './media-content.model';

export const sampleWithRequiredData: IMediaContent = {
  id: 26075,
  language: 'chase',
  difficultyLevel: 24924,
};

export const sampleWithPartialData: IMediaContent = {
  id: 11930,
  text: 'duh',
  language: 'instead faithfully',
  difficultyLevel: 21196,
};

export const sampleWithFullData: IMediaContent = {
  id: 93,
  text: 'patiently eek',
  audio: '../fake-data/blob/hipster.png',
  audioContentType: 'unknown',
  uploadDateTime: dayjs('2025-01-26T02:28'),
  language: 'throughout crumble',
  difficultyLevel: 21728,
};

export const sampleWithNewData: NewMediaContent = {
  language: 'through weary',
  difficultyLevel: 14469,
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
