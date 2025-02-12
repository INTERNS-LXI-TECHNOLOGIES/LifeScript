import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import GpsEntryResolve from './route/gps-entry-routing-resolve.service';

const gpsEntryRoute: Routes = [
  {
    path: '',
    loadComponent: () => import('./list/gps-entry.component').then(m => m.GpsEntryComponent),
    data: {
      defaultSort: `id,${ASC}`,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    loadComponent: () => import('./detail/gps-entry-detail.component').then(m => m.GpsEntryDetailComponent),
    resolve: {
      gpsEntry: GpsEntryResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    loadComponent: () => import('./update/gps-entry-update.component').then(m => m.GpsEntryUpdateComponent),
    resolve: {
      gpsEntry: GpsEntryResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    loadComponent: () => import('./update/gps-entry-update.component').then(m => m.GpsEntryUpdateComponent),
    resolve: {
      gpsEntry: GpsEntryResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default gpsEntryRoute;
