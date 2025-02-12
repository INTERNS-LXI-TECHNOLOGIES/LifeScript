import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable, map } from 'rxjs';

import dayjs from 'dayjs/esm';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IGpsEntry, NewGpsEntry } from '../gps-entry.model';

export type PartialUpdateGpsEntry = Partial<IGpsEntry> & Pick<IGpsEntry, 'id'>;

type RestOf<T extends IGpsEntry | NewGpsEntry> = Omit<T, 'timestamp'> & {
  timestamp?: string | null;
};

export type RestGpsEntry = RestOf<IGpsEntry>;

export type NewRestGpsEntry = RestOf<NewGpsEntry>;

export type PartialUpdateRestGpsEntry = RestOf<PartialUpdateGpsEntry>;

export type EntityResponseType = HttpResponse<IGpsEntry>;
export type EntityArrayResponseType = HttpResponse<IGpsEntry[]>;

@Injectable({ providedIn: 'root' })
export class GpsEntryService {
  protected readonly http = inject(HttpClient);
  protected readonly applicationConfigService = inject(ApplicationConfigService);

  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/gps-entries');

  create(gpsEntry: NewGpsEntry): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(gpsEntry);
    return this.http
      .post<RestGpsEntry>(this.resourceUrl, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  update(gpsEntry: IGpsEntry): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(gpsEntry);
    return this.http
      .put<RestGpsEntry>(`${this.resourceUrl}/${this.getGpsEntryIdentifier(gpsEntry)}`, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  partialUpdate(gpsEntry: PartialUpdateGpsEntry): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(gpsEntry);
    return this.http
      .patch<RestGpsEntry>(`${this.resourceUrl}/${this.getGpsEntryIdentifier(gpsEntry)}`, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http
      .get<RestGpsEntry>(`${this.resourceUrl}/${id}`, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http
      .get<RestGpsEntry[]>(this.resourceUrl, { params: options, observe: 'response' })
      .pipe(map(res => this.convertResponseArrayFromServer(res)));
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getGpsEntryIdentifier(gpsEntry: Pick<IGpsEntry, 'id'>): number {
    return gpsEntry.id;
  }

  compareGpsEntry(o1: Pick<IGpsEntry, 'id'> | null, o2: Pick<IGpsEntry, 'id'> | null): boolean {
    return o1 && o2 ? this.getGpsEntryIdentifier(o1) === this.getGpsEntryIdentifier(o2) : o1 === o2;
  }

  addGpsEntryToCollectionIfMissing<Type extends Pick<IGpsEntry, 'id'>>(
    gpsEntryCollection: Type[],
    ...gpsEntriesToCheck: (Type | null | undefined)[]
  ): Type[] {
    const gpsEntries: Type[] = gpsEntriesToCheck.filter(isPresent);
    if (gpsEntries.length > 0) {
      const gpsEntryCollectionIdentifiers = gpsEntryCollection.map(gpsEntryItem => this.getGpsEntryIdentifier(gpsEntryItem));
      const gpsEntriesToAdd = gpsEntries.filter(gpsEntryItem => {
        const gpsEntryIdentifier = this.getGpsEntryIdentifier(gpsEntryItem);
        if (gpsEntryCollectionIdentifiers.includes(gpsEntryIdentifier)) {
          return false;
        }
        gpsEntryCollectionIdentifiers.push(gpsEntryIdentifier);
        return true;
      });
      return [...gpsEntriesToAdd, ...gpsEntryCollection];
    }
    return gpsEntryCollection;
  }

  protected convertDateFromClient<T extends IGpsEntry | NewGpsEntry | PartialUpdateGpsEntry>(gpsEntry: T): RestOf<T> {
    return {
      ...gpsEntry,
      timestamp: gpsEntry.timestamp?.toJSON() ?? null,
    };
  }

  protected convertDateFromServer(restGpsEntry: RestGpsEntry): IGpsEntry {
    return {
      ...restGpsEntry,
      timestamp: restGpsEntry.timestamp ? dayjs(restGpsEntry.timestamp) : undefined,
    };
  }

  protected convertResponseFromServer(res: HttpResponse<RestGpsEntry>): HttpResponse<IGpsEntry> {
    return res.clone({
      body: res.body ? this.convertDateFromServer(res.body) : null,
    });
  }

  protected convertResponseArrayFromServer(res: HttpResponse<RestGpsEntry[]>): HttpResponse<IGpsEntry[]> {
    return res.clone({
      body: res.body ? res.body.map(item => this.convertDateFromServer(item)) : null,
    });
  }
}
