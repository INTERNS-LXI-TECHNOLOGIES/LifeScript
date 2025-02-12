import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { EMPTY, Observable, of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IChild } from '../child.model';
import { ChildService } from '../service/child.service';

const childResolve = (route: ActivatedRouteSnapshot): Observable<null | IChild> => {
  const id = route.params.id;
  if (id) {
    return inject(ChildService)
      .find(id)
      .pipe(
        mergeMap((child: HttpResponse<IChild>) => {
          if (child.body) {
            return of(child.body);
          }
          inject(Router).navigate(['404']);
          return EMPTY;
        }),
      );
  }
  return of(null);
};

export default childResolve;
