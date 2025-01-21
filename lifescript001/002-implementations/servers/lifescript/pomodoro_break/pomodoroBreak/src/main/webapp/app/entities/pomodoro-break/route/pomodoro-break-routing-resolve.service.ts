import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { EMPTY, Observable, of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IPomodoroBreak } from '../pomodoro-break.model';
import { PomodoroBreakService } from '../service/pomodoro-break.service';

const pomodoroBreakResolve = (route: ActivatedRouteSnapshot): Observable<null | IPomodoroBreak> => {
  const id = route.params.id;
  if (id) {
    return inject(PomodoroBreakService)
      .find(id)
      .pipe(
        mergeMap((pomodoroBreak: HttpResponse<IPomodoroBreak>) => {
          if (pomodoroBreak.body) {
            return of(pomodoroBreak.body);
          }
          inject(Router).navigate(['404']);
          return EMPTY;
        }),
      );
  }
  return of(null);
};

export default pomodoroBreakResolve;
