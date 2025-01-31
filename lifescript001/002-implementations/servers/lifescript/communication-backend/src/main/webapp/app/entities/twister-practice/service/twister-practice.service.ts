import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { ITwisterPractice, NewTwisterPractice } from '../twister-practice.model';

export type PartialUpdateTwisterPractice = Partial<ITwisterPractice> & Pick<ITwisterPractice, 'id'>;

export type EntityResponseType = HttpResponse<ITwisterPractice>;
export type EntityArrayResponseType = HttpResponse<ITwisterPractice[]>;

@Injectable({ providedIn: 'root' })
export class TwisterPracticeService {
  protected readonly http = inject(HttpClient);
  protected readonly applicationConfigService = inject(ApplicationConfigService);

  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/twister-practices');

  create(twisterPractice: NewTwisterPractice): Observable<EntityResponseType> {
    return this.http.post<ITwisterPractice>(this.resourceUrl, twisterPractice, { observe: 'response' });
  }

  update(twisterPractice: ITwisterPractice): Observable<EntityResponseType> {
    return this.http.put<ITwisterPractice>(`${this.resourceUrl}/${this.getTwisterPracticeIdentifier(twisterPractice)}`, twisterPractice, {
      observe: 'response',
    });
  }

  partialUpdate(twisterPractice: PartialUpdateTwisterPractice): Observable<EntityResponseType> {
    return this.http.patch<ITwisterPractice>(`${this.resourceUrl}/${this.getTwisterPracticeIdentifier(twisterPractice)}`, twisterPractice, {
      observe: 'response',
    });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<ITwisterPractice>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<ITwisterPractice[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getTwisterPracticeIdentifier(twisterPractice: Pick<ITwisterPractice, 'id'>): number {
    return twisterPractice.id;
  }

  compareTwisterPractice(o1: Pick<ITwisterPractice, 'id'> | null, o2: Pick<ITwisterPractice, 'id'> | null): boolean {
    return o1 && o2 ? this.getTwisterPracticeIdentifier(o1) === this.getTwisterPracticeIdentifier(o2) : o1 === o2;
  }

  addTwisterPracticeToCollectionIfMissing<Type extends Pick<ITwisterPractice, 'id'>>(
    twisterPracticeCollection: Type[],
    ...twisterPracticesToCheck: (Type | null | undefined)[]
  ): Type[] {
    const twisterPractices: Type[] = twisterPracticesToCheck.filter(isPresent);
    if (twisterPractices.length > 0) {
      const twisterPracticeCollectionIdentifiers = twisterPracticeCollection.map(twisterPracticeItem =>
        this.getTwisterPracticeIdentifier(twisterPracticeItem),
      );
      const twisterPracticesToAdd = twisterPractices.filter(twisterPracticeItem => {
        const twisterPracticeIdentifier = this.getTwisterPracticeIdentifier(twisterPracticeItem);
        if (twisterPracticeCollectionIdentifiers.includes(twisterPracticeIdentifier)) {
          return false;
        }
        twisterPracticeCollectionIdentifiers.push(twisterPracticeIdentifier);
        return true;
      });
      return [...twisterPracticesToAdd, ...twisterPracticeCollection];
    }
    return twisterPracticeCollection;
  }
}
