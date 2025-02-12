import { IParent } from 'app/entities/parent/parent.model';

export interface IEmergencyContact {
  id: number;
  name?: string | null;
  type?: string | null;
  phoneNumber?: string | null;
  parent?: Pick<IParent, 'id'> | null;
}

export type NewEmergencyContact = Omit<IEmergencyContact, 'id'> & { id: null };
