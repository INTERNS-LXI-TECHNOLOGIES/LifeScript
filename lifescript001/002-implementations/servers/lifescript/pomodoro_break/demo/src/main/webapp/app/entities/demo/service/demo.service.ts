import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IDemo, NewDemo } from '../demo.model';

export type PartialUpdateDemo = Partial<IDemo> & Pick<IDemo, 'id'>;

export type EntityResponseType = HttpResponse<IDemo>;
export type EntityArrayResponseType = HttpResponse<IDemo[]>;

@Injectable({ providedIn: 'root' })
export class DemoService {
  protected readonly http = inject(HttpClient);
  protected readonly applicationConfigService = inject(ApplicationConfigService);

  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/demos');

  create(demo: NewDemo): Observable<EntityResponseType> {
    return this.http.post<IDemo>(this.resourceUrl, demo, { observe: 'response' });
  }

  update(demo: IDemo): Observable<EntityResponseType> {
    return this.http.put<IDemo>(`${this.resourceUrl}/${this.getDemoIdentifier(demo)}`, demo, { observe: 'response' });
  }

  partialUpdate(demo: PartialUpdateDemo): Observable<EntityResponseType> {
    return this.http.patch<IDemo>(`${this.resourceUrl}/${this.getDemoIdentifier(demo)}`, demo, { observe: 'response' });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IDemo>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IDemo[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getDemoIdentifier(demo: Pick<IDemo, 'id'>): number {
    return demo.id;
  }

  compareDemo(o1: Pick<IDemo, 'id'> | null, o2: Pick<IDemo, 'id'> | null): boolean {
    return o1 && o2 ? this.getDemoIdentifier(o1) === this.getDemoIdentifier(o2) : o1 === o2;
  }

  addDemoToCollectionIfMissing<Type extends Pick<IDemo, 'id'>>(
    demoCollection: Type[],
    ...demosToCheck: (Type | null | undefined)[]
  ): Type[] {
    const demos: Type[] = demosToCheck.filter(isPresent);
    if (demos.length > 0) {
      const demoCollectionIdentifiers = demoCollection.map(demoItem => this.getDemoIdentifier(demoItem));
      const demosToAdd = demos.filter(demoItem => {
        const demoIdentifier = this.getDemoIdentifier(demoItem);
        if (demoCollectionIdentifiers.includes(demoIdentifier)) {
          return false;
        }
        demoCollectionIdentifiers.push(demoIdentifier);
        return true;
      });
      return [...demosToAdd, ...demoCollection];
    }
    return demoCollection;
  }
}
