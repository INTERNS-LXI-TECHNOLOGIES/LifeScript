import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable, map } from 'rxjs';

import dayjs from 'dayjs/esm';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IPomodoroBreak, NewPomodoroBreak } from '../pomodoro-break.model';

export type PartialUpdatePomodoroBreak = Partial<IPomodoroBreak> & Pick<IPomodoroBreak, 'id'>;

type RestOf<T extends IPomodoroBreak | NewPomodoroBreak> = Omit<T, 'dateOfPomodoro' | 'timeOfPomodoroCreation'> & {
  dateOfPomodoro?: string | null;
  timeOfPomodoroCreation?: string | null;
};

export type RestPomodoroBreak = RestOf<IPomodoroBreak>;

export type NewRestPomodoroBreak = RestOf<NewPomodoroBreak>;

export type PartialUpdateRestPomodoroBreak = RestOf<PartialUpdatePomodoroBreak>;

export type EntityResponseType = HttpResponse<IPomodoroBreak>;
export type EntityArrayResponseType = HttpResponse<IPomodoroBreak[]>;

@Injectable({ providedIn: 'root' })
export class PomodoroBreakService {
  protected readonly http = inject(HttpClient);
  protected readonly applicationConfigService = inject(ApplicationConfigService);

  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/pomodoro-breaks');

  create(pomodoroBreak: NewPomodoroBreak): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(pomodoroBreak);
    return this.http
      .post<RestPomodoroBreak>(this.resourceUrl, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  update(pomodoroBreak: IPomodoroBreak): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(pomodoroBreak);
    return this.http
      .put<RestPomodoroBreak>(`${this.resourceUrl}/${this.getPomodoroBreakIdentifier(pomodoroBreak)}`, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  partialUpdate(pomodoroBreak: PartialUpdatePomodoroBreak): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(pomodoroBreak);
    return this.http
      .patch<RestPomodoroBreak>(`${this.resourceUrl}/${this.getPomodoroBreakIdentifier(pomodoroBreak)}`, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http
      .get<RestPomodoroBreak>(`${this.resourceUrl}/${id}`, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http
      .get<RestPomodoroBreak[]>(this.resourceUrl, { params: options, observe: 'response' })
      .pipe(map(res => this.convertResponseArrayFromServer(res)));
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getPomodoroBreakIdentifier(pomodoroBreak: Pick<IPomodoroBreak, 'id'>): number {
    return pomodoroBreak.id;
  }

  comparePomodoroBreak(o1: Pick<IPomodoroBreak, 'id'> | null, o2: Pick<IPomodoroBreak, 'id'> | null): boolean {
    return o1 && o2 ? this.getPomodoroBreakIdentifier(o1) === this.getPomodoroBreakIdentifier(o2) : o1 === o2;
  }

  addPomodoroBreakToCollectionIfMissing<Type extends Pick<IPomodoroBreak, 'id'>>(
    pomodoroBreakCollection: Type[],
    ...pomodoroBreaksToCheck: (Type | null | undefined)[]
  ): Type[] {
    const pomodoroBreaks: Type[] = pomodoroBreaksToCheck.filter(isPresent);
    if (pomodoroBreaks.length > 0) {
      const pomodoroBreakCollectionIdentifiers = pomodoroBreakCollection.map(pomodoroBreakItem =>
        this.getPomodoroBreakIdentifier(pomodoroBreakItem),
      );
      const pomodoroBreaksToAdd = pomodoroBreaks.filter(pomodoroBreakItem => {
        const pomodoroBreakIdentifier = this.getPomodoroBreakIdentifier(pomodoroBreakItem);
        if (pomodoroBreakCollectionIdentifiers.includes(pomodoroBreakIdentifier)) {
          return false;
        }
        pomodoroBreakCollectionIdentifiers.push(pomodoroBreakIdentifier);
        return true;
      });
      return [...pomodoroBreaksToAdd, ...pomodoroBreakCollection];
    }
    return pomodoroBreakCollection;
  }

  protected convertDateFromClient<T extends IPomodoroBreak | NewPomodoroBreak | PartialUpdatePomodoroBreak>(pomodoroBreak: T): RestOf<T> {
    return {
      ...pomodoroBreak,
      dateOfPomodoro: pomodoroBreak.dateOfPomodoro?.toJSON() ?? null,
      timeOfPomodoroCreation: pomodoroBreak.timeOfPomodoroCreation?.toJSON() ?? null,
    };
  }

  protected convertDateFromServer(restPomodoroBreak: RestPomodoroBreak): IPomodoroBreak {
    return {
      ...restPomodoroBreak,
      dateOfPomodoro: restPomodoroBreak.dateOfPomodoro ? dayjs(restPomodoroBreak.dateOfPomodoro) : undefined,
      timeOfPomodoroCreation: restPomodoroBreak.timeOfPomodoroCreation ? dayjs(restPomodoroBreak.timeOfPomodoroCreation) : undefined,
    };
  }

  protected convertResponseFromServer(res: HttpResponse<RestPomodoroBreak>): HttpResponse<IPomodoroBreak> {
    return res.clone({
      body: res.body ? this.convertDateFromServer(res.body) : null,
    });
  }

  protected convertResponseArrayFromServer(res: HttpResponse<RestPomodoroBreak[]>): HttpResponse<IPomodoroBreak[]> {
    return res.clone({
      body: res.body ? res.body.map(item => this.convertDateFromServer(item)) : null,
    });
  }
}
