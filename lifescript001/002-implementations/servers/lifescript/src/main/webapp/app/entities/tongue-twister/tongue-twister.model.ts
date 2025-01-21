import { IUser } from 'app/entities/user/user.model';

export interface ITongueTwister {
  id: number;
  text?: string | null;
  language?: string | null;
  difficultyLevel?: number | null;
  creator?: Pick<IUser, 'id' | 'login'> | null;
}

export type NewTongueTwister = Omit<ITongueTwister, 'id'> & { id: null };
