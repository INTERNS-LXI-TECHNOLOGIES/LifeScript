import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { EMPTY, Observable, of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IHabitTracker } from '../habit-tracker.model';
import { HabitTrackerService } from '../service/habit-tracker.service';

const habitTrackerResolve = (route: ActivatedRouteSnapshot): Observable<null | IHabitTracker> => {
  const id = route.params.id;
  if (id) {
    return inject(HabitTrackerService)
      .find(id)
      .pipe(
        mergeMap((habitTracker: HttpResponse<IHabitTracker>) => {
          if (habitTracker.body) {
            return of(habitTracker.body);
          }
          inject(Router).navigate(['404']);
          return EMPTY;
        }),
      );
  }
  return of(null);
};

export default habitTrackerResolve;
