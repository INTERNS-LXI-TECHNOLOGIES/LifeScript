import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import DemoResolve from './route/demo-routing-resolve.service';

const demoRoute: Routes = [
  {
    path: '',
    loadComponent: () => import('./list/demo.component').then(m => m.DemoComponent),
    data: {
      defaultSort: `id,${ASC}`,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    loadComponent: () => import('./detail/demo-detail.component').then(m => m.DemoDetailComponent),
    resolve: {
      demo: DemoResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    loadComponent: () => import('./update/demo-update.component').then(m => m.DemoUpdateComponent),
    resolve: {
      demo: DemoResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    loadComponent: () => import('./update/demo-update.component').then(m => m.DemoUpdateComponent),
    resolve: {
      demo: DemoResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default demoRoute;
