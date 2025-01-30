import { IMediaContent } from 'app/entities/media-content/media-content.model';

export interface ITwisterPractice {
  id: number;
  score?: number | null;
  timesPracticed?: number | null;
  corrections?: string | null;
  mediaContent?: IMediaContent | null;
}

export type NewTwisterPractice = Omit<ITwisterPractice, 'id'> & { id: null };
