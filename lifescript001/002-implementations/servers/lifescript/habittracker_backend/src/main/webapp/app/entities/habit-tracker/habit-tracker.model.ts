export interface IHabitTracker {
  id: number;
  habitId?: number | null;
  habitName?: string | null;
  description?: string | null;
  startDate?: number | null;
  endDate?: string | null;
}
