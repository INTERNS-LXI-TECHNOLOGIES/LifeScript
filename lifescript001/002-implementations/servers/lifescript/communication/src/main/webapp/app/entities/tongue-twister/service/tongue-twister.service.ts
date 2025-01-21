import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { ITongueTwister, NewTongueTwister } from '../tongue-twister.model';

export type PartialUpdateTongueTwister = Partial<ITongueTwister> & Pick<ITongueTwister, 'id'>;

export type EntityResponseType = HttpResponse<ITongueTwister>;
export type EntityArrayResponseType = HttpResponse<ITongueTwister[]>;

@Injectable({ providedIn: 'root' })
export class TongueTwisterService {
  protected readonly http = inject(HttpClient);
  protected readonly applicationConfigService = inject(ApplicationConfigService);

  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/tongue-twisters');

  create(tongueTwister: NewTongueTwister): Observable<EntityResponseType> {
    return this.http.post<ITongueTwister>(this.resourceUrl, tongueTwister, { observe: 'response' });
  }

  update(tongueTwister: ITongueTwister): Observable<EntityResponseType> {
    return this.http.put<ITongueTwister>(`${this.resourceUrl}/${this.getTongueTwisterIdentifier(tongueTwister)}`, tongueTwister, {
      observe: 'response',
    });
  }

  partialUpdate(tongueTwister: PartialUpdateTongueTwister): Observable<EntityResponseType> {
    return this.http.patch<ITongueTwister>(`${this.resourceUrl}/${this.getTongueTwisterIdentifier(tongueTwister)}`, tongueTwister, {
      observe: 'response',
    });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<ITongueTwister>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<ITongueTwister[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getTongueTwisterIdentifier(tongueTwister: Pick<ITongueTwister, 'id'>): number {
    return tongueTwister.id;
  }

  compareTongueTwister(o1: Pick<ITongueTwister, 'id'> | null, o2: Pick<ITongueTwister, 'id'> | null): boolean {
    return o1 && o2 ? this.getTongueTwisterIdentifier(o1) === this.getTongueTwisterIdentifier(o2) : o1 === o2;
  }

  addTongueTwisterToCollectionIfMissing<Type extends Pick<ITongueTwister, 'id'>>(
    tongueTwisterCollection: Type[],
    ...tongueTwistersToCheck: (Type | null | undefined)[]
  ): Type[] {
    const tongueTwisters: Type[] = tongueTwistersToCheck.filter(isPresent);
    if (tongueTwisters.length > 0) {
      const tongueTwisterCollectionIdentifiers = tongueTwisterCollection.map(tongueTwisterItem =>
        this.getTongueTwisterIdentifier(tongueTwisterItem),
      );
      const tongueTwistersToAdd = tongueTwisters.filter(tongueTwisterItem => {
        const tongueTwisterIdentifier = this.getTongueTwisterIdentifier(tongueTwisterItem);
        if (tongueTwisterCollectionIdentifiers.includes(tongueTwisterIdentifier)) {
          return false;
        }
        tongueTwisterCollectionIdentifiers.push(tongueTwisterIdentifier);
        return true;
      });
      return [...tongueTwistersToAdd, ...tongueTwisterCollection];
    }
    return tongueTwisterCollection;
  }
}
