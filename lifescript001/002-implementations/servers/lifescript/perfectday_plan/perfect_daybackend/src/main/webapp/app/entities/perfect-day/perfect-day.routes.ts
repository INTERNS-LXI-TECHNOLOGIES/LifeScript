import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import PerfectDayResolve from './route/perfect-day-routing-resolve.service';

const perfectDayRoute: Routes = [
  {
    path: '',
    loadComponent: () => import('./list/perfect-day.component').then(m => m.PerfectDayComponent),
    data: {
      defaultSort: `id,${ASC}`,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    loadComponent: () => import('./detail/perfect-day-detail.component').then(m => m.PerfectDayDetailComponent),
    resolve: {
      perfectDay: PerfectDayResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    loadComponent: () => import('./update/perfect-day-update.component').then(m => m.PerfectDayUpdateComponent),
    resolve: {
      perfectDay: PerfectDayResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    loadComponent: () => import('./update/perfect-day-update.component').then(m => m.PerfectDayUpdateComponent),
    resolve: {
      perfectDay: PerfectDayResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default perfectDayRoute;
