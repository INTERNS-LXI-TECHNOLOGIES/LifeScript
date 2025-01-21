import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable, map } from 'rxjs';

import dayjs from 'dayjs/esm';

import { isPresent } from 'app/core/util/operators';
import { DATE_FORMAT } from 'app/config/input.constants';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IPerfectDay, NewPerfectDay } from '../perfect-day.model';

export type PartialUpdatePerfectDay = Partial<IPerfectDay> & Pick<IPerfectDay, 'id'>;

type RestOf<T extends IPerfectDay | NewPerfectDay> = Omit<T, 'date'> & {
  date?: string | null;
};

export type RestPerfectDay = RestOf<IPerfectDay>;

export type NewRestPerfectDay = RestOf<NewPerfectDay>;

export type PartialUpdateRestPerfectDay = RestOf<PartialUpdatePerfectDay>;

export type EntityResponseType = HttpResponse<IPerfectDay>;
export type EntityArrayResponseType = HttpResponse<IPerfectDay[]>;

@Injectable({ providedIn: 'root' })
export class PerfectDayService {
  protected readonly http = inject(HttpClient);
  protected readonly applicationConfigService = inject(ApplicationConfigService);

  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/perfect-days');

  create(perfectDay: NewPerfectDay): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(perfectDay);
    return this.http
      .post<RestPerfectDay>(this.resourceUrl, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  update(perfectDay: IPerfectDay): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(perfectDay);
    return this.http
      .put<RestPerfectDay>(`${this.resourceUrl}/${this.getPerfectDayIdentifier(perfectDay)}`, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  partialUpdate(perfectDay: PartialUpdatePerfectDay): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(perfectDay);
    return this.http
      .patch<RestPerfectDay>(`${this.resourceUrl}/${this.getPerfectDayIdentifier(perfectDay)}`, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http
      .get<RestPerfectDay>(`${this.resourceUrl}/${id}`, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http
      .get<RestPerfectDay[]>(this.resourceUrl, { params: options, observe: 'response' })
      .pipe(map(res => this.convertResponseArrayFromServer(res)));
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getPerfectDayIdentifier(perfectDay: Pick<IPerfectDay, 'id'>): number {
    return perfectDay.id;
  }

  comparePerfectDay(o1: Pick<IPerfectDay, 'id'> | null, o2: Pick<IPerfectDay, 'id'> | null): boolean {
    return o1 && o2 ? this.getPerfectDayIdentifier(o1) === this.getPerfectDayIdentifier(o2) : o1 === o2;
  }

  addPerfectDayToCollectionIfMissing<Type extends Pick<IPerfectDay, 'id'>>(
    perfectDayCollection: Type[],
    ...perfectDaysToCheck: (Type | null | undefined)[]
  ): Type[] {
    const perfectDays: Type[] = perfectDaysToCheck.filter(isPresent);
    if (perfectDays.length > 0) {
      const perfectDayCollectionIdentifiers = perfectDayCollection.map(perfectDayItem => this.getPerfectDayIdentifier(perfectDayItem));
      const perfectDaysToAdd = perfectDays.filter(perfectDayItem => {
        const perfectDayIdentifier = this.getPerfectDayIdentifier(perfectDayItem);
        if (perfectDayCollectionIdentifiers.includes(perfectDayIdentifier)) {
          return false;
        }
        perfectDayCollectionIdentifiers.push(perfectDayIdentifier);
        return true;
      });
      return [...perfectDaysToAdd, ...perfectDayCollection];
    }
    return perfectDayCollection;
  }

  protected convertDateFromClient<T extends IPerfectDay | NewPerfectDay | PartialUpdatePerfectDay>(perfectDay: T): RestOf<T> {
    return {
      ...perfectDay,
      date: perfectDay.date?.format(DATE_FORMAT) ?? null,
    };
  }

  protected convertDateFromServer(restPerfectDay: RestPerfectDay): IPerfectDay {
    return {
      ...restPerfectDay,
      date: restPerfectDay.date ? dayjs(restPerfectDay.date) : undefined,
    };
  }

  protected convertResponseFromServer(res: HttpResponse<RestPerfectDay>): HttpResponse<IPerfectDay> {
    return res.clone({
      body: res.body ? this.convertDateFromServer(res.body) : null,
    });
  }

  protected convertResponseArrayFromServer(res: HttpResponse<RestPerfectDay[]>): HttpResponse<IPerfectDay[]> {
    return res.clone({
      body: res.body ? res.body.map(item => this.convertDateFromServer(item)) : null,
    });
  }
}
