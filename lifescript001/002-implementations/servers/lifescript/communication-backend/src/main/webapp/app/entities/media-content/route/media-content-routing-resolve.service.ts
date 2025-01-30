import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { EMPTY, Observable, of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IMediaContent } from '../media-content.model';
import { MediaContentService } from '../service/media-content.service';

const mediaContentResolve = (route: ActivatedRouteSnapshot): Observable<null | IMediaContent> => {
  const id = route.params.id;
  if (id) {
    return inject(MediaContentService)
      .find(id)
      .pipe(
        mergeMap((mediaContent: HttpResponse<IMediaContent>) => {
          if (mediaContent.body) {
            return of(mediaContent.body);
          }
          inject(Router).navigate(['404']);
          return EMPTY;
        }),
      );
  }
  return of(null);
};

export default mediaContentResolve;
