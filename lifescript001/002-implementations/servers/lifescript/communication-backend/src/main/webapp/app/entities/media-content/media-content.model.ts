import dayjs from 'dayjs/esm';

export interface IMediaContent {
  id: number;
  text?: string | null;
  audio?: string | null;
  audioContentType?: string | null;
  uploadDateTime?: dayjs.Dayjs | null;
  language?: string | null;
  difficultyLevel?: number | null;
}

export type NewMediaContent = Omit<IMediaContent, 'id'> & { id: null };
