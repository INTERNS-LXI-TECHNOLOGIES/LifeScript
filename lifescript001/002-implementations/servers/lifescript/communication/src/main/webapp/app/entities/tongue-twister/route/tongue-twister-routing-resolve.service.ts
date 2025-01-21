import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { EMPTY, Observable, of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { ITongueTwister } from '../tongue-twister.model';
import { TongueTwisterService } from '../service/tongue-twister.service';

const tongueTwisterResolve = (route: ActivatedRouteSnapshot): Observable<null | ITongueTwister> => {
  const id = route.params.id;
  if (id) {
    return inject(TongueTwisterService)
      .find(id)
      .pipe(
        mergeMap((tongueTwister: HttpResponse<ITongueTwister>) => {
          if (tongueTwister.body) {
            return of(tongueTwister.body);
          }
          inject(Router).navigate(['404']);
          return EMPTY;
        }),
      );
  }
  return of(null);
};

export default tongueTwisterResolve;
