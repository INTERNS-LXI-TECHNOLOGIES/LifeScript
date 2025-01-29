import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import UserEntityResolve from './route/user-entity-routing-resolve.service';

const userEntityRoute: Routes = [
  {
    path: '',
    loadComponent: () => import('./list/user-entity.component').then(m => m.UserEntityComponent),
    data: {
      defaultSort: `id,${ASC}`,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    loadComponent: () => import('./detail/user-entity-detail.component').then(m => m.UserEntityDetailComponent),
    resolve: {
      userEntity: UserEntityResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    loadComponent: () => import('./update/user-entity-update.component').then(m => m.UserEntityUpdateComponent),
    resolve: {
      userEntity: UserEntityResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    loadComponent: () => import('./update/user-entity-update.component').then(m => m.UserEntityUpdateComponent),
    resolve: {
      userEntity: UserEntityResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default userEntityRoute;
