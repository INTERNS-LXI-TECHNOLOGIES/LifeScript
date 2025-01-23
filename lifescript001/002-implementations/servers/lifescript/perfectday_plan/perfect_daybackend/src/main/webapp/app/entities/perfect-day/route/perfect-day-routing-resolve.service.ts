import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { EMPTY, Observable, of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IPerfectDay } from '../perfect-day.model';
import { PerfectDayService } from '../service/perfect-day.service';

const perfectDayResolve = (route: ActivatedRouteSnapshot): Observable<null | IPerfectDay> => {
  const id = route.params.id;
  if (id) {
    return inject(PerfectDayService)
      .find(id)
      .pipe(
        mergeMap((perfectDay: HttpResponse<IPerfectDay>) => {
          if (perfectDay.body) {
            return of(perfectDay.body);
          }
          inject(Router).navigate(['404']);
          return EMPTY;
        }),
      );
  }
  return of(null);
};

export default perfectDayResolve;
