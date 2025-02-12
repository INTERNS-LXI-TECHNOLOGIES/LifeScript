import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import EmergencyContactResolve from './route/emergency-contact-routing-resolve.service';

const emergencyContactRoute: Routes = [
  {
    path: '',
    loadComponent: () => import('./list/emergency-contact.component').then(m => m.EmergencyContactComponent),
    data: {
      defaultSort: `id,${ASC}`,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    loadComponent: () => import('./detail/emergency-contact-detail.component').then(m => m.EmergencyContactDetailComponent),
    resolve: {
      emergencyContact: EmergencyContactResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    loadComponent: () => import('./update/emergency-contact-update.component').then(m => m.EmergencyContactUpdateComponent),
    resolve: {
      emergencyContact: EmergencyContactResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    loadComponent: () => import('./update/emergency-contact-update.component').then(m => m.EmergencyContactUpdateComponent),
    resolve: {
      emergencyContact: EmergencyContactResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default emergencyContactRoute;
