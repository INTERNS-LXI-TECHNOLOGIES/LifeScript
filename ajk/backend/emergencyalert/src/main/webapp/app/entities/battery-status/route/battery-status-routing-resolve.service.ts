import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { EMPTY, Observable, of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IBatteryStatus } from '../battery-status.model';
import { BatteryStatusService } from '../service/battery-status.service';

const batteryStatusResolve = (route: ActivatedRouteSnapshot): Observable<null | IBatteryStatus> => {
  const id = route.params.id;
  if (id) {
    return inject(BatteryStatusService)
      .find(id)
      .pipe(
        mergeMap((batteryStatus: HttpResponse<IBatteryStatus>) => {
          if (batteryStatus.body) {
            return of(batteryStatus.body);
          }
          inject(Router).navigate(['404']);
          return EMPTY;
        }),
      );
  }
  return of(null);
};

export default batteryStatusResolve;
