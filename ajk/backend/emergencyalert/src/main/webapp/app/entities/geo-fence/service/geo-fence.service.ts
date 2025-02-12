import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IGeoFence, NewGeoFence } from '../geo-fence.model';

export type PartialUpdateGeoFence = Partial<IGeoFence> & Pick<IGeoFence, 'id'>;

export type EntityResponseType = HttpResponse<IGeoFence>;
export type EntityArrayResponseType = HttpResponse<IGeoFence[]>;

@Injectable({ providedIn: 'root' })
export class GeoFenceService {
  protected readonly http = inject(HttpClient);
  protected readonly applicationConfigService = inject(ApplicationConfigService);

  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/geo-fences');

  create(geoFence: NewGeoFence): Observable<EntityResponseType> {
    return this.http.post<IGeoFence>(this.resourceUrl, geoFence, { observe: 'response' });
  }

  update(geoFence: IGeoFence): Observable<EntityResponseType> {
    return this.http.put<IGeoFence>(`${this.resourceUrl}/${this.getGeoFenceIdentifier(geoFence)}`, geoFence, { observe: 'response' });
  }

  partialUpdate(geoFence: PartialUpdateGeoFence): Observable<EntityResponseType> {
    return this.http.patch<IGeoFence>(`${this.resourceUrl}/${this.getGeoFenceIdentifier(geoFence)}`, geoFence, { observe: 'response' });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IGeoFence>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IGeoFence[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getGeoFenceIdentifier(geoFence: Pick<IGeoFence, 'id'>): number {
    return geoFence.id;
  }

  compareGeoFence(o1: Pick<IGeoFence, 'id'> | null, o2: Pick<IGeoFence, 'id'> | null): boolean {
    return o1 && o2 ? this.getGeoFenceIdentifier(o1) === this.getGeoFenceIdentifier(o2) : o1 === o2;
  }

  addGeoFenceToCollectionIfMissing<Type extends Pick<IGeoFence, 'id'>>(
    geoFenceCollection: Type[],
    ...geoFencesToCheck: (Type | null | undefined)[]
  ): Type[] {
    const geoFences: Type[] = geoFencesToCheck.filter(isPresent);
    if (geoFences.length > 0) {
      const geoFenceCollectionIdentifiers = geoFenceCollection.map(geoFenceItem => this.getGeoFenceIdentifier(geoFenceItem));
      const geoFencesToAdd = geoFences.filter(geoFenceItem => {
        const geoFenceIdentifier = this.getGeoFenceIdentifier(geoFenceItem);
        if (geoFenceCollectionIdentifiers.includes(geoFenceIdentifier)) {
          return false;
        }
        geoFenceCollectionIdentifiers.push(geoFenceIdentifier);
        return true;
      });
      return [...geoFencesToAdd, ...geoFenceCollection];
    }
    return geoFenceCollection;
  }
}
