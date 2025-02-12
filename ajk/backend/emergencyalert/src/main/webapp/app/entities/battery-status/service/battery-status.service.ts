import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IBatteryStatus, NewBatteryStatus } from '../battery-status.model';

export type PartialUpdateBatteryStatus = Partial<IBatteryStatus> & Pick<IBatteryStatus, 'id'>;

export type EntityResponseType = HttpResponse<IBatteryStatus>;
export type EntityArrayResponseType = HttpResponse<IBatteryStatus[]>;

@Injectable({ providedIn: 'root' })
export class BatteryStatusService {
  protected readonly http = inject(HttpClient);
  protected readonly applicationConfigService = inject(ApplicationConfigService);

  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/battery-statuses');

  create(batteryStatus: NewBatteryStatus): Observable<EntityResponseType> {
    return this.http.post<IBatteryStatus>(this.resourceUrl, batteryStatus, { observe: 'response' });
  }

  update(batteryStatus: IBatteryStatus): Observable<EntityResponseType> {
    return this.http.put<IBatteryStatus>(`${this.resourceUrl}/${this.getBatteryStatusIdentifier(batteryStatus)}`, batteryStatus, {
      observe: 'response',
    });
  }

  partialUpdate(batteryStatus: PartialUpdateBatteryStatus): Observable<EntityResponseType> {
    return this.http.patch<IBatteryStatus>(`${this.resourceUrl}/${this.getBatteryStatusIdentifier(batteryStatus)}`, batteryStatus, {
      observe: 'response',
    });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IBatteryStatus>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IBatteryStatus[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getBatteryStatusIdentifier(batteryStatus: Pick<IBatteryStatus, 'id'>): number {
    return batteryStatus.id;
  }

  compareBatteryStatus(o1: Pick<IBatteryStatus, 'id'> | null, o2: Pick<IBatteryStatus, 'id'> | null): boolean {
    return o1 && o2 ? this.getBatteryStatusIdentifier(o1) === this.getBatteryStatusIdentifier(o2) : o1 === o2;
  }

  addBatteryStatusToCollectionIfMissing<Type extends Pick<IBatteryStatus, 'id'>>(
    batteryStatusCollection: Type[],
    ...batteryStatusesToCheck: (Type | null | undefined)[]
  ): Type[] {
    const batteryStatuses: Type[] = batteryStatusesToCheck.filter(isPresent);
    if (batteryStatuses.length > 0) {
      const batteryStatusCollectionIdentifiers = batteryStatusCollection.map(batteryStatusItem =>
        this.getBatteryStatusIdentifier(batteryStatusItem),
      );
      const batteryStatusesToAdd = batteryStatuses.filter(batteryStatusItem => {
        const batteryStatusIdentifier = this.getBatteryStatusIdentifier(batteryStatusItem);
        if (batteryStatusCollectionIdentifiers.includes(batteryStatusIdentifier)) {
          return false;
        }
        batteryStatusCollectionIdentifiers.push(batteryStatusIdentifier);
        return true;
      });
      return [...batteryStatusesToAdd, ...batteryStatusCollection];
    }
    return batteryStatusCollection;
  }
}
