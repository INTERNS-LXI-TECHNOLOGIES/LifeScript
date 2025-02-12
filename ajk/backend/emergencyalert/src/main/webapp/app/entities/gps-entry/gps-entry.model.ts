import dayjs from 'dayjs/esm';
import { IChild } from 'app/entities/child/child.model';

export interface IGpsEntry {
  id: number;
  latitude?: number | null;
  longitude?: number | null;
  timestamp?: dayjs.Dayjs | null;
  deviceId?: string | null;
  status?: string | null;
  child?: Pick<IChild, 'id'> | null;
}

export type NewGpsEntry = Omit<IGpsEntry, 'id'> & { id: null };
