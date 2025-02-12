import { Routes } from '@angular/router';

const routes: Routes = [
  {
    path: 'authority',
    data: { pageTitle: 'emergencyAlertApp.adminAuthority.home.title' },
    loadChildren: () => import('./admin/authority/authority.routes'),
  },
  {
    path: 'alert',
    data: { pageTitle: 'emergencyAlertApp.alert.home.title' },
    loadChildren: () => import('./alert/alert.routes'),
  },
  {
    path: 'battery-status',
    data: { pageTitle: 'emergencyAlertApp.batteryStatus.home.title' },
    loadChildren: () => import('./battery-status/battery-status.routes'),
  },
  {
    path: 'child',
    data: { pageTitle: 'emergencyAlertApp.child.home.title' },
    loadChildren: () => import('./child/child.routes'),
  },
  {
    path: 'emergency-contact',
    data: { pageTitle: 'emergencyAlertApp.emergencyContact.home.title' },
    loadChildren: () => import('./emergency-contact/emergency-contact.routes'),
  },
  {
    path: 'geo-fence',
    data: { pageTitle: 'emergencyAlertApp.geoFence.home.title' },
    loadChildren: () => import('./geo-fence/geo-fence.routes'),
  },
  {
    path: 'gps-entry',
    data: { pageTitle: 'emergencyAlertApp.gpsEntry.home.title' },
    loadChildren: () => import('./gps-entry/gps-entry.routes'),
  },
  {
    path: 'parent',
    data: { pageTitle: 'emergencyAlertApp.parent.home.title' },
    loadChildren: () => import('./parent/parent.routes'),
  },
  {
    path: 'teacher',
    data: { pageTitle: 'emergencyAlertApp.teacher.home.title' },
    loadChildren: () => import('./teacher/teacher.routes'),
  },
  /* jhipster-needle-add-entity-route - JHipster will add entity modules routes here */
];

export default routes;
