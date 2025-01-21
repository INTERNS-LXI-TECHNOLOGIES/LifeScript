export interface IHabitTracker {
  id: number;
  habitId?: number | null;
  habitName?: string | null;
  description?: string | null;
  startDate?: string | null;
  endDate?: string | null;
}

export type NewHabitTracker = Omit<IHabitTracker, 'id'> & { id: null };
