import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { EMPTY, Observable, of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IUserEntity } from '../user-entity.model';
import { UserEntityService } from '../service/user-entity.service';

const userEntityResolve = (route: ActivatedRouteSnapshot): Observable<null | IUserEntity> => {
  const id = route.params.id;
  if (id) {
    return inject(UserEntityService)
      .find(id)
      .pipe(
        mergeMap((userEntity: HttpResponse<IUserEntity>) => {
          if (userEntity.body) {
            return of(userEntity.body);
          }
          inject(Router).navigate(['404']);
          return EMPTY;
        }),
      );
  }
  return of(null);
};

export default userEntityResolve;
