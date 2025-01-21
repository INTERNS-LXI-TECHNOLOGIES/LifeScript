import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import PomodoroBreakResolve from './route/pomodoro-break-routing-resolve.service';

const pomodoroBreakRoute: Routes = [
  {
    path: '',
    loadComponent: () => import('./list/pomodoro-break.component').then(m => m.PomodoroBreakComponent),
    data: {
      defaultSort: `id,${ASC}`,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    loadComponent: () => import('./detail/pomodoro-break-detail.component').then(m => m.PomodoroBreakDetailComponent),
    resolve: {
      pomodoroBreak: PomodoroBreakResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    loadComponent: () => import('./update/pomodoro-break-update.component').then(m => m.PomodoroBreakUpdateComponent),
    resolve: {
      pomodoroBreak: PomodoroBreakResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    loadComponent: () => import('./update/pomodoro-break-update.component').then(m => m.PomodoroBreakUpdateComponent),
    resolve: {
      pomodoroBreak: PomodoroBreakResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default pomodoroBreakRoute;
