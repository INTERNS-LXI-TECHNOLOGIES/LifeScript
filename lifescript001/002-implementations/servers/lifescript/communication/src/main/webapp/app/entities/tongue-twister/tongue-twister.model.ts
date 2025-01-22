export interface ITongueTwister {
  id: number;
  text?: string | null;
  language?: string | null;
  difficultyLevel?: number | null;
}

export type NewTongueTwister = Omit<ITongueTwister, 'id'> & { id: null };
