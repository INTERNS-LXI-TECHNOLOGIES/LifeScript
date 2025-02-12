export interface IBatteryStatus {
  id: number;
  batteryLevel?: number | null;
}

export type NewBatteryStatus = Omit<IBatteryStatus, 'id'> & { id: null };
