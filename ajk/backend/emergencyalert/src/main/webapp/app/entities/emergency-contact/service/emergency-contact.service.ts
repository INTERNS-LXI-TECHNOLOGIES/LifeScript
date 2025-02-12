import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IEmergencyContact, NewEmergencyContact } from '../emergency-contact.model';

export type PartialUpdateEmergencyContact = Partial<IEmergencyContact> & Pick<IEmergencyContact, 'id'>;

export type EntityResponseType = HttpResponse<IEmergencyContact>;
export type EntityArrayResponseType = HttpResponse<IEmergencyContact[]>;

@Injectable({ providedIn: 'root' })
export class EmergencyContactService {
  protected readonly http = inject(HttpClient);
  protected readonly applicationConfigService = inject(ApplicationConfigService);

  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/emergency-contacts');

  create(emergencyContact: NewEmergencyContact): Observable<EntityResponseType> {
    return this.http.post<IEmergencyContact>(this.resourceUrl, emergencyContact, { observe: 'response' });
  }

  update(emergencyContact: IEmergencyContact): Observable<EntityResponseType> {
    return this.http.put<IEmergencyContact>(
      `${this.resourceUrl}/${this.getEmergencyContactIdentifier(emergencyContact)}`,
      emergencyContact,
      { observe: 'response' },
    );
  }

  partialUpdate(emergencyContact: PartialUpdateEmergencyContact): Observable<EntityResponseType> {
    return this.http.patch<IEmergencyContact>(
      `${this.resourceUrl}/${this.getEmergencyContactIdentifier(emergencyContact)}`,
      emergencyContact,
      { observe: 'response' },
    );
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IEmergencyContact>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IEmergencyContact[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getEmergencyContactIdentifier(emergencyContact: Pick<IEmergencyContact, 'id'>): number {
    return emergencyContact.id;
  }

  compareEmergencyContact(o1: Pick<IEmergencyContact, 'id'> | null, o2: Pick<IEmergencyContact, 'id'> | null): boolean {
    return o1 && o2 ? this.getEmergencyContactIdentifier(o1) === this.getEmergencyContactIdentifier(o2) : o1 === o2;
  }

  addEmergencyContactToCollectionIfMissing<Type extends Pick<IEmergencyContact, 'id'>>(
    emergencyContactCollection: Type[],
    ...emergencyContactsToCheck: (Type | null | undefined)[]
  ): Type[] {
    const emergencyContacts: Type[] = emergencyContactsToCheck.filter(isPresent);
    if (emergencyContacts.length > 0) {
      const emergencyContactCollectionIdentifiers = emergencyContactCollection.map(emergencyContactItem =>
        this.getEmergencyContactIdentifier(emergencyContactItem),
      );
      const emergencyContactsToAdd = emergencyContacts.filter(emergencyContactItem => {
        const emergencyContactIdentifier = this.getEmergencyContactIdentifier(emergencyContactItem);
        if (emergencyContactCollectionIdentifiers.includes(emergencyContactIdentifier)) {
          return false;
        }
        emergencyContactCollectionIdentifiers.push(emergencyContactIdentifier);
        return true;
      });
      return [...emergencyContactsToAdd, ...emergencyContactCollection];
    }
    return emergencyContactCollection;
  }
}
