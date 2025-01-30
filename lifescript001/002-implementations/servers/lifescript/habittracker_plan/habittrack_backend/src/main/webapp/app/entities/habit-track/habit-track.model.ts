export interface IHabitTrack {
  id: number;
  habitId?: number | null;
  habitName?: string | null;
  description?: string | null;
  category?: string | null;
  startDate?: string | null;
  endDate?: string | null;
}

export type NewHabitTrack = Omit<IHabitTrack, 'id'> & { id: null };
