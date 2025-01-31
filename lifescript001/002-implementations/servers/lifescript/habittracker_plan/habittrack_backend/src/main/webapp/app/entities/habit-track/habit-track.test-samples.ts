import { IHabitTrack, NewHabitTrack } from './habit-track.model';

export const sampleWithRequiredData: IHabitTrack = {
  id: 1104,
};

export const sampleWithPartialData: IHabitTrack = {
  id: 13847,
  habitId: 9616,
  habitName: 'graduate',
  category: 'searchingly',
  startDate: 'inside unsteady yowza',
};

export const sampleWithFullData: IHabitTrack = {
  id: 10251,
  habitId: 15148,
  habitName: 'pause',
  description: 'old-fashioned cute',
  category: 'thoroughly',
  startDate: 'joyfully by demob',
  endDate: 'lest',
};

export const sampleWithNewData: NewHabitTrack = {
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
