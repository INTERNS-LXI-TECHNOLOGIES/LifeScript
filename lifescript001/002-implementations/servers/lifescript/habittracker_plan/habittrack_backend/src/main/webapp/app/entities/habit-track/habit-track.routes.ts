import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import HabitTrackResolve from './route/habit-track-routing-resolve.service';

const habitTrackRoute: Routes = [
  {
    path: '',
    loadComponent: () => import('./list/habit-track.component').then(m => m.HabitTrackComponent),
    data: {
      defaultSort: `id,${ASC}`,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    loadComponent: () => import('./detail/habit-track-detail.component').then(m => m.HabitTrackDetailComponent),
    resolve: {
      habitTrack: HabitTrackResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    loadComponent: () => import('./update/habit-track-update.component').then(m => m.HabitTrackUpdateComponent),
    resolve: {
      habitTrack: HabitTrackResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    loadComponent: () => import('./update/habit-track-update.component').then(m => m.HabitTrackUpdateComponent),
    resolve: {
      habitTrack: HabitTrackResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default habitTrackRoute;
