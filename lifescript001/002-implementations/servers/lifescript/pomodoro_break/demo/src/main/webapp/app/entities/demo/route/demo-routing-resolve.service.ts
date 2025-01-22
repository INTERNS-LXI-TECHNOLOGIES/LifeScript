import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { EMPTY, Observable, of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IDemo } from '../demo.model';
import { DemoService } from '../service/demo.service';

const demoResolve = (route: ActivatedRouteSnapshot): Observable<null | IDemo> => {
  const id = route.params.id;
  if (id) {
    return inject(DemoService)
      .find(id)
      .pipe(
        mergeMap((demo: HttpResponse<IDemo>) => {
          if (demo.body) {
            return of(demo.body);
          }
          inject(Router).navigate(['404']);
          return EMPTY;
        }),
      );
  }
  return of(null);
};

export default demoResolve;
