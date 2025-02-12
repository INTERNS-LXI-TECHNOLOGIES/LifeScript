import dayjs from 'dayjs/esm';
import { IChild } from 'app/entities/child/child.model';

export interface IAlert {
  id: number;
  latitude?: number | null;
  longitude?: number | null;
  timestamp?: dayjs.Dayjs | null;
  deviceId?: string | null;
  status?: string | null;
  child?: Pick<IChild, 'id'> | null;
}

export type NewAlert = Omit<IAlert, 'id'> & { id: null };
