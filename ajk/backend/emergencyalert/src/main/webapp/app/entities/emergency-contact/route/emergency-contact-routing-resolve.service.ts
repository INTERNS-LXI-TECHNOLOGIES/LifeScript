import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { EMPTY, Observable, of } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IEmergencyContact } from '../emergency-contact.model';
import { EmergencyContactService } from '../service/emergency-contact.service';

const emergencyContactResolve = (route: ActivatedRouteSnapshot): Observable<null | IEmergencyContact> => {
  const id = route.params.id;
  if (id) {
    return inject(EmergencyContactService)
      .find(id)
      .pipe(
        mergeMap((emergencyContact: HttpResponse<IEmergencyContact>) => {
          if (emergencyContact.body) {
            return of(emergencyContact.body);
          }
          inject(Router).navigate(['404']);
          return EMPTY;
        }),
      );
  }
  return of(null);
};

export default emergencyContactResolve;
