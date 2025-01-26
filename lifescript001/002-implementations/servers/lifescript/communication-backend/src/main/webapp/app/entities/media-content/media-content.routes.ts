import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import MediaContentResolve from './route/media-content-routing-resolve.service';

const mediaContentRoute: Routes = [
  {
    path: '',
    loadComponent: () => import('./list/media-content.component').then(m => m.MediaContentComponent),
    data: {
      defaultSort: `id,${ASC}`,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    loadComponent: () => import('./detail/media-content-detail.component').then(m => m.MediaContentDetailComponent),
    resolve: {
      mediaContent: MediaContentResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    loadComponent: () => import('./update/media-content-update.component').then(m => m.MediaContentUpdateComponent),
    resolve: {
      mediaContent: MediaContentResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    loadComponent: () => import('./update/media-content-update.component').then(m => m.MediaContentUpdateComponent),
    resolve: {
      mediaContent: MediaContentResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default mediaContentRoute;
