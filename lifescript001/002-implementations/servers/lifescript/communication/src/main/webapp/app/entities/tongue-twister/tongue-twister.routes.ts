import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import TongueTwisterResolve from './route/tongue-twister-routing-resolve.service';

const tongueTwisterRoute: Routes = [
  {
    path: '',
    loadComponent: () => import('./list/tongue-twister.component').then(m => m.TongueTwisterComponent),
    data: {
      defaultSort: `id,${ASC}`,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    loadComponent: () => import('./detail/tongue-twister-detail.component').then(m => m.TongueTwisterDetailComponent),
    resolve: {
      tongueTwister: TongueTwisterResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    loadComponent: () => import('./update/tongue-twister-update.component').then(m => m.TongueTwisterUpdateComponent),
    resolve: {
      tongueTwister: TongueTwisterResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    loadComponent: () => import('./update/tongue-twister-update.component').then(m => m.TongueTwisterUpdateComponent),
    resolve: {
      tongueTwister: TongueTwisterResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default tongueTwisterRoute;
