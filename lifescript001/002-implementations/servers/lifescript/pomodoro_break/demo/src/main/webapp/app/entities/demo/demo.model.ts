export interface IDemo {
  id: number;
  username?: string | null;
  mobileNumber?: number | null;
}

export type NewDemo = Omit<IDemo, 'id'> & { id: null };
