import { IGeoFence } from 'app/entities/geo-fence/geo-fence.model';
import { IBatteryStatus } from 'app/entities/battery-status/battery-status.model';
import { ITeacher } from 'app/entities/teacher/teacher.model';
import { IParent } from 'app/entities/parent/parent.model';

export interface IChild {
  id: number;
  name?: string | null;
  age?: number | null;
  emergencyContact?: string | null;
  geoFence?: Pick<IGeoFence, 'id'> | null;
  batteryStatus?: Pick<IBatteryStatus, 'id'> | null;
  teacher?: Pick<ITeacher, 'id'> | null;
  parent?: Pick<IParent, 'id'> | null;
}

export type NewChild = Omit<IChild, 'id'> & { id: null };
