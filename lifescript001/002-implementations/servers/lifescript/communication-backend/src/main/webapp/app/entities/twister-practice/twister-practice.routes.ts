import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import TwisterPracticeResolve from './route/twister-practice-routing-resolve.service';

const twisterPracticeRoute: Routes = [
  {
    path: '',
    loadComponent: () => import('./list/twister-practice.component').then(m => m.TwisterPracticeComponent),
    data: {
      defaultSort: `id,${ASC}`,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    loadComponent: () => import('./detail/twister-practice-detail.component').then(m => m.TwisterPracticeDetailComponent),
    resolve: {
      twisterPractice: TwisterPracticeResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    loadComponent: () => import('./update/twister-practice-update.component').then(m => m.TwisterPracticeUpdateComponent),
    resolve: {
      twisterPractice: TwisterPracticeResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    loadComponent: () => import('./update/twister-practice-update.component').then(m => m.TwisterPracticeUpdateComponent),
    resolve: {
      twisterPractice: TwisterPracticeResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default twisterPracticeRoute;
