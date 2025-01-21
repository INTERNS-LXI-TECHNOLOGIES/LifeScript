import { IHabitTracker, NewHabitTracker } from './habit-tracker.model';

export const sampleWithRequiredData: IHabitTracker = {
  id: 25526,
};

export const sampleWithPartialData: IHabitTracker = {
  id: 4855,
  habitName: 'dramatize',
  endDate: 'simple noisily',
};

export const sampleWithFullData: IHabitTracker = {
  id: 15115,
  habitId: 22972,
  habitName: 'separately',
  description: 'suddenly pfft infinite',
  startDate: 'norm',
  endDate: 'yin intent intermarry',
};

export const sampleWithNewData: NewHabitTracker = {
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
