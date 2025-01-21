import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import { DailyJournalComponent } from './list/daily-journal.component';
import { DailyJournalDetailComponent } from './detail/daily-journal-detail.component';
import { DailyJournalUpdateComponent } from './update/daily-journal-update.component';
import DailyJournalResolve from './route/daily-journal-routing-resolve.service';

const dailyJournalRoute: Routes = [
  {
    path: '',
    component: DailyJournalComponent,
    data: {
      defaultSort: 'id,' + ASC,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    component: DailyJournalDetailComponent,
    resolve: {
      dailyJournal: DailyJournalResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    component: DailyJournalUpdateComponent,
    resolve: {
      dailyJournal: DailyJournalResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    component: DailyJournalUpdateComponent,
    resolve: {
      dailyJournal: DailyJournalResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default dailyJournalRoute;
