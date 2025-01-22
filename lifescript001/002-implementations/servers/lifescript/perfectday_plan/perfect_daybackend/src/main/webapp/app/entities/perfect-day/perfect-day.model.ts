import dayjs from 'dayjs/esm';

export interface IPerfectDay {
  id: number;
  title?: string | null;
  description?: string | null;
  date?: dayjs.Dayjs | null;
}

export type NewPerfectDay = Omit<IPerfectDay, 'id'> & { id: null };
