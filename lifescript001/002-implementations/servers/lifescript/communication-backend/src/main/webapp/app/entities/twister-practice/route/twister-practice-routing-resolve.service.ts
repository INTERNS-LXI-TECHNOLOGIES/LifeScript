import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { EMPTY, Observable, of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { ITwisterPractice } from '../twister-practice.model';
import { TwisterPracticeService } from '../service/twister-practice.service';

const twisterPracticeResolve = (route: ActivatedRouteSnapshot): Observable<null | ITwisterPractice> => {
  const id = route.params.id;
  if (id) {
    return inject(TwisterPracticeService)
      .find(id)
      .pipe(
        mergeMap((twisterPractice: HttpResponse<ITwisterPractice>) => {
          if (twisterPractice.body) {
            return of(twisterPractice.body);
          }
          inject(Router).navigate(['404']);
          return EMPTY;
        }),
      );
  }
  return of(null);
};

export default twisterPracticeResolve;
