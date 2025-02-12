import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { EMPTY, Observable, of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IGeoFence } from '../geo-fence.model';
import { GeoFenceService } from '../service/geo-fence.service';

const geoFenceResolve = (route: ActivatedRouteSnapshot): Observable<null | IGeoFence> => {
  const id = route.params.id;
  if (id) {
    return inject(GeoFenceService)
      .find(id)
      .pipe(
        mergeMap((geoFence: HttpResponse<IGeoFence>) => {
          if (geoFence.body) {
            return of(geoFence.body);
          }
          inject(Router).navigate(['404']);
          return EMPTY;
        }),
      );
  }
  return of(null);
};

export default geoFenceResolve;
