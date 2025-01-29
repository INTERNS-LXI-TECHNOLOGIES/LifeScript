import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { EMPTY, Observable, of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IHabitTrack } from '../habit-track.model';
import { HabitTrackService } from '../service/habit-track.service';

const habitTrackResolve = (route: ActivatedRouteSnapshot): Observable<null | IHabitTrack> => {
  const id = route.params.id;
  if (id) {
    return inject(HabitTrackService)
      .find(id)
      .pipe(
        mergeMap((habitTrack: HttpResponse<IHabitTrack>) => {
          if (habitTrack.body) {
            return of(habitTrack.body);
          }
          inject(Router).navigate(['404']);
          return EMPTY;
        }),
      );
  }
  return of(null);
};

export default habitTrackResolve;
