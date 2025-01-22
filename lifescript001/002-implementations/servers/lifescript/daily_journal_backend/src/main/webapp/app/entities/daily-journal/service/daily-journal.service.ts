import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { map } from 'rxjs/operators';

import dayjs from 'dayjs/esm';

import { isPresent } from 'app/core/util/operators';
import { DATE_FORMAT } from 'app/config/input.constants';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IDailyJournal, NewDailyJournal } from '../daily-journal.model';

export type PartialUpdateDailyJournal = Partial<IDailyJournal> & Pick<IDailyJournal, 'id'>;

type RestOf<T extends IDailyJournal | NewDailyJournal> = Omit<T, 'date'> & {
  date?: string | null;
};

export type RestDailyJournal = RestOf<IDailyJournal>;

export type NewRestDailyJournal = RestOf<NewDailyJournal>;

export type PartialUpdateRestDailyJournal = RestOf<PartialUpdateDailyJournal>;

export type EntityResponseType = HttpResponse<IDailyJournal>;
export type EntityArrayResponseType = HttpResponse<IDailyJournal[]>;

@Injectable({ providedIn: 'root' })
export class DailyJournalService {
  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/daily-journals');

  constructor(
    protected http: HttpClient,
    protected applicationConfigService: ApplicationConfigService,
  ) {}

  create(dailyJournal: NewDailyJournal): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(dailyJournal);
    return this.http
      .post<RestDailyJournal>(this.resourceUrl, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  update(dailyJournal: IDailyJournal): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(dailyJournal);
    return this.http
      .put<RestDailyJournal>(`${this.resourceUrl}/${this.getDailyJournalIdentifier(dailyJournal)}`, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  partialUpdate(dailyJournal: PartialUpdateDailyJournal): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(dailyJournal);
    return this.http
      .patch<RestDailyJournal>(`${this.resourceUrl}/${this.getDailyJournalIdentifier(dailyJournal)}`, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http
      .get<RestDailyJournal>(`${this.resourceUrl}/${id}`, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http
      .get<RestDailyJournal[]>(this.resourceUrl, { params: options, observe: 'response' })
      .pipe(map(res => this.convertResponseArrayFromServer(res)));
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getDailyJournalIdentifier(dailyJournal: Pick<IDailyJournal, 'id'>): number {
    return dailyJournal.id;
  }

  compareDailyJournal(o1: Pick<IDailyJournal, 'id'> | null, o2: Pick<IDailyJournal, 'id'> | null): boolean {
    return o1 && o2 ? this.getDailyJournalIdentifier(o1) === this.getDailyJournalIdentifier(o2) : o1 === o2;
  }

  addDailyJournalToCollectionIfMissing<Type extends Pick<IDailyJournal, 'id'>>(
    dailyJournalCollection: Type[],
    ...dailyJournalsToCheck: (Type | null | undefined)[]
  ): Type[] {
    const dailyJournals: Type[] = dailyJournalsToCheck.filter(isPresent);
    if (dailyJournals.length > 0) {
      const dailyJournalCollectionIdentifiers = dailyJournalCollection.map(
        dailyJournalItem => this.getDailyJournalIdentifier(dailyJournalItem)!,
      );
      const dailyJournalsToAdd = dailyJournals.filter(dailyJournalItem => {
        const dailyJournalIdentifier = this.getDailyJournalIdentifier(dailyJournalItem);
        if (dailyJournalCollectionIdentifiers.includes(dailyJournalIdentifier)) {
          return false;
        }
        dailyJournalCollectionIdentifiers.push(dailyJournalIdentifier);
        return true;
      });
      return [...dailyJournalsToAdd, ...dailyJournalCollection];
    }
    return dailyJournalCollection;
  }

  protected convertDateFromClient<T extends IDailyJournal | NewDailyJournal | PartialUpdateDailyJournal>(dailyJournal: T): RestOf<T> {
    return {
      ...dailyJournal,
      date: dailyJournal.date?.format(DATE_FORMAT) ?? null,
    };
  }

  protected convertDateFromServer(restDailyJournal: RestDailyJournal): IDailyJournal {
    return {
      ...restDailyJournal,
      date: restDailyJournal.date ? dayjs(restDailyJournal.date) : undefined,
    };
  }

  protected convertResponseFromServer(res: HttpResponse<RestDailyJournal>): HttpResponse<IDailyJournal> {
    return res.clone({
      body: res.body ? this.convertDateFromServer(res.body) : null,
    });
  }

  protected convertResponseArrayFromServer(res: HttpResponse<RestDailyJournal[]>): HttpResponse<IDailyJournal[]> {
    return res.clone({
      body: res.body ? res.body.map(item => this.convertDateFromServer(item)) : null,
    });
  }
}
