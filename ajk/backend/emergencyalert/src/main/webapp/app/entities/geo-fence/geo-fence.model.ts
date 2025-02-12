export interface IGeoFence {
  id: number;
  safeZones?: string | null;
}

export type NewGeoFence = Omit<IGeoFence, 'id'> & { id: null };
