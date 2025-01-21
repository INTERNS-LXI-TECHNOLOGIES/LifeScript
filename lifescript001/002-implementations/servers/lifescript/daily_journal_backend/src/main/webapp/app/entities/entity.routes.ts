import { Routes } from '@angular/router';

const routes: Routes = [
  {
    path: 'daily-journal',
    data: { pageTitle: 'dailyJournalApp.dailyJournal.home.title' },
    loadChildren: () => import('./daily-journal/daily-journal.routes'),
  },
  /* jhipster-needle-add-entity-route - JHipster will add entity modules routes here */
];

export default routes;
