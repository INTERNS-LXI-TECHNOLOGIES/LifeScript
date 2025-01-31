export interface IUserProfile {
  id: number;
  nickName?: string | null;
  address?: string | null;
}

export type NewUserProfile = Omit<IUserProfile, 'id'> & { id: null };
