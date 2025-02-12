import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import BatteryStatusResolve from './route/battery-status-routing-resolve.service';

const batteryStatusRoute: Routes = [
  {
    path: '',
    loadComponent: () => import('./list/battery-status.component').then(m => m.BatteryStatusComponent),
    data: {
      defaultSort: `id,${ASC}`,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    loadComponent: () => import('./detail/battery-status-detail.component').then(m => m.BatteryStatusDetailComponent),
    resolve: {
      batteryStatus: BatteryStatusResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    loadComponent: () => import('./update/battery-status-update.component').then(m => m.BatteryStatusUpdateComponent),
    resolve: {
      batteryStatus: BatteryStatusResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    loadComponent: () => import('./update/battery-status-update.component').then(m => m.BatteryStatusUpdateComponent),
    resolve: {
      batteryStatus: BatteryStatusResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default batteryStatusRoute;
