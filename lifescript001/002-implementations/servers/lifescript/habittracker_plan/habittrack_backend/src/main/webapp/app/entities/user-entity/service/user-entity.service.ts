import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IUserEntity, NewUserEntity } from '../user-entity.model';

export type PartialUpdateUserEntity = Partial<IUserEntity> & Pick<IUserEntity, 'id'>;

export type EntityResponseType = HttpResponse<IUserEntity>;
export type EntityArrayResponseType = HttpResponse<IUserEntity[]>;

@Injectable({ providedIn: 'root' })
export class UserEntityService {
  protected readonly http = inject(HttpClient);
  protected readonly applicationConfigService = inject(ApplicationConfigService);

  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/user-entities');

  create(userEntity: NewUserEntity): Observable<EntityResponseType> {
    return this.http.post<IUserEntity>(this.resourceUrl, userEntity, { observe: 'response' });
  }

  update(userEntity: IUserEntity): Observable<EntityResponseType> {
    return this.http.put<IUserEntity>(`${this.resourceUrl}/${this.getUserEntityIdentifier(userEntity)}`, userEntity, {
      observe: 'response',
    });
  }

  partialUpdate(userEntity: PartialUpdateUserEntity): Observable<EntityResponseType> {
    return this.http.patch<IUserEntity>(`${this.resourceUrl}/${this.getUserEntityIdentifier(userEntity)}`, userEntity, {
      observe: 'response',
    });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IUserEntity>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IUserEntity[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getUserEntityIdentifier(userEntity: Pick<IUserEntity, 'id'>): number {
    return userEntity.id;
  }

  compareUserEntity(o1: Pick<IUserEntity, 'id'> | null, o2: Pick<IUserEntity, 'id'> | null): boolean {
    return o1 && o2 ? this.getUserEntityIdentifier(o1) === this.getUserEntityIdentifier(o2) : o1 === o2;
  }

  addUserEntityToCollectionIfMissing<Type extends Pick<IUserEntity, 'id'>>(
    userEntityCollection: Type[],
    ...userEntitiesToCheck: (Type | null | undefined)[]
  ): Type[] {
    const userEntities: Type[] = userEntitiesToCheck.filter(isPresent);
    if (userEntities.length > 0) {
      const userEntityCollectionIdentifiers = userEntityCollection.map(userEntityItem => this.getUserEntityIdentifier(userEntityItem));
      const userEntitiesToAdd = userEntities.filter(userEntityItem => {
        const userEntityIdentifier = this.getUserEntityIdentifier(userEntityItem);
        if (userEntityCollectionIdentifiers.includes(userEntityIdentifier)) {
          return false;
        }
        userEntityCollectionIdentifiers.push(userEntityIdentifier);
        return true;
      });
      return [...userEntitiesToAdd, ...userEntityCollection];
    }
    return userEntityCollection;
  }
}
