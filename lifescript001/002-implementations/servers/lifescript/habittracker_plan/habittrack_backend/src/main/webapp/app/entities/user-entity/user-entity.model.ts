export interface IUserEntity {
  id: number;
  userId?: number | null;
  userName?: string | null;
}

export type NewUserEntity = Omit<IUserEntity, 'id'> & { id: null };
