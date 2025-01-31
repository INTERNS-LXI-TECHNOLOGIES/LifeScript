import { Routes } from '@angular/router';

const routes: Routes = [
  {
    path: 'authority',
    data: { pageTitle: 'communicationBackendApp.adminAuthority.home.title' },
    loadChildren: () => import('./admin/authority/authority.routes'),
  },
  {
    path: 'user-profile',
    data: { pageTitle: 'communicationBackendApp.userProfile.home.title' },
    loadChildren: () => import('./user-profile/user-profile.routes'),
  },
  {
    path: 'media-content',
    data: { pageTitle: 'communicationBackendApp.mediaContent.home.title' },
    loadChildren: () => import('./media-content/media-content.routes'),
  },
  {
    path: 'twister-practice',
    data: { pageTitle: 'communicationBackendApp.twisterPractice.home.title' },
    loadChildren: () => import('./twister-practice/twister-practice.routes'),
  },
  /* jhipster-needle-add-entity-route - JHipster will add entity modules routes here */
];

export default routes;
