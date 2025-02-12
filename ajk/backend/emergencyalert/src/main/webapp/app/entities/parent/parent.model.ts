export interface IParent {
  id: number;
  name?: string | null;
  phoneNumber?: string | null;
}

export type NewParent = Omit<IParent, 'id'> & { id: null };
