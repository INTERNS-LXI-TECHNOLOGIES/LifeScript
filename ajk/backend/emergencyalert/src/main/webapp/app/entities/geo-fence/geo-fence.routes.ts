import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import GeoFenceResolve from './route/geo-fence-routing-resolve.service';

const geoFenceRoute: Routes = [
  {
    path: '',
    loadComponent: () => import('./list/geo-fence.component').then(m => m.GeoFenceComponent),
    data: {
      defaultSort: `id,${ASC}`,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    loadComponent: () => import('./detail/geo-fence-detail.component').then(m => m.GeoFenceDetailComponent),
    resolve: {
      geoFence: GeoFenceResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    loadComponent: () => import('./update/geo-fence-update.component').then(m => m.GeoFenceUpdateComponent),
    resolve: {
      geoFence: GeoFenceResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    loadComponent: () => import('./update/geo-fence-update.component').then(m => m.GeoFenceUpdateComponent),
    resolve: {
      geoFence: GeoFenceResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default geoFenceRoute;
