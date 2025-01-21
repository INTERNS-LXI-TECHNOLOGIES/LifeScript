import { Routes } from '@angular/router';

const routes: Routes = [
  {
    path: 'authority',
    data: { pageTitle: 'pomodoroBreakApp.adminAuthority.home.title' },
    loadChildren: () => import('./admin/authority/authority.routes'),
  },
  {
    path: 'pomodoro-break',
    data: { pageTitle: 'pomodoroBreakApp.pomodoroBreak.home.title' },
    loadChildren: () => import('./pomodoro-break/pomodoro-break.routes'),
  },
  /* jhipster-needle-add-entity-route - JHipster will add entity modules routes here */
];

export default routes;
