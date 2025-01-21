import { Routes } from '@angular/router';

const routes: Routes = [
  {
    path: 'authority',
    data: { pageTitle: 'perfectdaybackendApp.adminAuthority.home.title' },
    loadChildren: () => import('./admin/authority/authority.routes'),
  },
  {
    path: 'perfect-day',
    data: { pageTitle: 'perfectdaybackendApp.perfectDay.home.title' },
    loadChildren: () => import('./perfect-day/perfect-day.routes'),
  },
  /* jhipster-needle-add-entity-route - JHipster will add entity modules routes here */
];

export default routes;
