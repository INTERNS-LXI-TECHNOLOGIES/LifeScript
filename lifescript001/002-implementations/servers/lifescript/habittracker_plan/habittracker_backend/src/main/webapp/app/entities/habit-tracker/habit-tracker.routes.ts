import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import HabitTrackerResolve from './route/habit-tracker-routing-resolve.service';

const habitTrackerRoute: Routes = [
  {
    path: '',
    loadComponent: () => import('./list/habit-tracker.component').then(m => m.HabitTrackerComponent),
    data: {
      defaultSort: `id,${ASC}`,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    loadComponent: () => import('./detail/habit-tracker-detail.component').then(m => m.HabitTrackerDetailComponent),
    resolve: {
      habitTracker: HabitTrackerResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    loadComponent: () => import('./update/habit-tracker-update.component').then(m => m.HabitTrackerUpdateComponent),
    resolve: {
      habitTracker: HabitTrackerResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    loadComponent: () => import('./update/habit-tracker-update.component').then(m => m.HabitTrackerUpdateComponent),
    resolve: {
      habitTracker: HabitTrackerResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default habitTrackerRoute;
