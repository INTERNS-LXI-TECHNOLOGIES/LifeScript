import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { of, EMPTY, Observable } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IDailyJournal } from '../daily-journal.model';
import { DailyJournalService } from '../service/daily-journal.service';

export const dailyJournalResolve = (route: ActivatedRouteSnapshot): Observable<null | IDailyJournal> => {
  const id = route.params['id'];
  if (id) {
    return inject(DailyJournalService)
      .find(id)
      .pipe(
        mergeMap((dailyJournal: HttpResponse<IDailyJournal>) => {
          if (dailyJournal.body) {
            return of(dailyJournal.body);
          } else {
            inject(Router).navigate(['404']);
            return EMPTY;
          }
        }),
      );
  }
  return of(null);
};

export default dailyJournalResolve;
