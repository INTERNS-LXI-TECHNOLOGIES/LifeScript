export interface ITeacher {
  id: number;
  name?: string | null;
  school?: string | null;
}

export type NewTeacher = Omit<ITeacher, 'id'> & { id: null };
