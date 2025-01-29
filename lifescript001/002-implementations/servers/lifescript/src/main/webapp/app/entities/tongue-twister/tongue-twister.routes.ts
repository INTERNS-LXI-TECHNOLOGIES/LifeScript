import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import { TongueTwisterComponent } from './list/tongue-twister.component';
import { TongueTwisterDetailComponent } from './detail/tongue-twister-detail.component';
import { TongueTwisterUpdateComponent } from './update/tongue-twister-update.component';
import TongueTwisterResolve from './route/tongue-twister-routing-resolve.service';

const tongueTwisterRoute: Routes = [
  {
    path: '',
    component: TongueTwisterComponent,
    data: {
      defaultSort: 'id,' + ASC,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    component: TongueTwisterDetailComponent,
    resolve: {
      tongueTwister: TongueTwisterResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    component: TongueTwisterUpdateComponent,
    resolve: {
      tongueTwister: TongueTwisterResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    component: TongueTwisterUpdateComponent,
    resolve: {
      tongueTwister: TongueTwisterResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default tongueTwisterRoute;
