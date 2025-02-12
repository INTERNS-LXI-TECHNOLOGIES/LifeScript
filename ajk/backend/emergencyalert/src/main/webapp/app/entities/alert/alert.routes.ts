import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import AlertResolve from './route/alert-routing-resolve.service';

const alertRoute: Routes = [
  {
    path: '',
    loadComponent: () => import('./list/alert.component').then(m => m.AlertComponent),
    data: {
      defaultSort: `id,${ASC}`,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    loadComponent: () => import('./detail/alert-detail.component').then(m => m.AlertDetailComponent),
    resolve: {
      alert: AlertResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    loadComponent: () => import('./update/alert-update.component').then(m => m.AlertUpdateComponent),
    resolve: {
      alert: AlertResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    loadComponent: () => import('./update/alert-update.component').then(m => m.AlertUpdateComponent),
    resolve: {
      alert: AlertResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default alertRoute;
