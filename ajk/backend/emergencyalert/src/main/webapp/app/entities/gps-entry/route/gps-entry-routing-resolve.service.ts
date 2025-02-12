import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { EMPTY, Observable, of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IGpsEntry } from '../gps-entry.model';
import { GpsEntryService } from '../service/gps-entry.service';

const gpsEntryResolve = (route: ActivatedRouteSnapshot): Observable<null | IGpsEntry> => {
  const id = route.params.id;
  if (id) {
    return inject(GpsEntryService)
      .find(id)
      .pipe(
        mergeMap((gpsEntry: HttpResponse<IGpsEntry>) => {
          if (gpsEntry.body) {
            return of(gpsEntry.body);
          }
          inject(Router).navigate(['404']);
          return EMPTY;
        }),
      );
  }
  return of(null);
};

export default gpsEntryResolve;
