import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IHabitTracker, NewHabitTracker } from '../habit-tracker.model';

export type PartialUpdateHabitTracker = Partial<IHabitTracker> & Pick<IHabitTracker, 'id'>;

export type EntityResponseType = HttpResponse<IHabitTracker>;
export type EntityArrayResponseType = HttpResponse<IHabitTracker[]>;

@Injectable({ providedIn: 'root' })
export class HabitTrackerService {
  protected readonly http = inject(HttpClient);
  protected readonly applicationConfigService = inject(ApplicationConfigService);

  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/habit-trackers');

  create(habitTracker: NewHabitTracker): Observable<EntityResponseType> {
    return this.http.post<IHabitTracker>(this.resourceUrl, habitTracker, { observe: 'response' });
  }

  update(habitTracker: IHabitTracker): Observable<EntityResponseType> {
    return this.http.put<IHabitTracker>(`${this.resourceUrl}/${this.getHabitTrackerIdentifier(habitTracker)}`, habitTracker, {
      observe: 'response',
    });
  }

  partialUpdate(habitTracker: PartialUpdateHabitTracker): Observable<EntityResponseType> {
    return this.http.patch<IHabitTracker>(`${this.resourceUrl}/${this.getHabitTrackerIdentifier(habitTracker)}`, habitTracker, {
      observe: 'response',
    });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IHabitTracker>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IHabitTracker[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getHabitTrackerIdentifier(habitTracker: Pick<IHabitTracker, 'id'>): number {
    return habitTracker.id;
  }

  compareHabitTracker(o1: Pick<IHabitTracker, 'id'> | null, o2: Pick<IHabitTracker, 'id'> | null): boolean {
    return o1 && o2 ? this.getHabitTrackerIdentifier(o1) === this.getHabitTrackerIdentifier(o2) : o1 === o2;
  }

  addHabitTrackerToCollectionIfMissing<Type extends Pick<IHabitTracker, 'id'>>(
    habitTrackerCollection: Type[],
    ...habitTrackersToCheck: (Type | null | undefined)[]
  ): Type[] {
    const habitTrackers: Type[] = habitTrackersToCheck.filter(isPresent);
    if (habitTrackers.length > 0) {
      const habitTrackerCollectionIdentifiers = habitTrackerCollection.map(habitTrackerItem =>
        this.getHabitTrackerIdentifier(habitTrackerItem),
      );
      const habitTrackersToAdd = habitTrackers.filter(habitTrackerItem => {
        const habitTrackerIdentifier = this.getHabitTrackerIdentifier(habitTrackerItem);
        if (habitTrackerCollectionIdentifiers.includes(habitTrackerIdentifier)) {
          return false;
        }
        habitTrackerCollectionIdentifiers.push(habitTrackerIdentifier);
        return true;
      });
      return [...habitTrackersToAdd, ...habitTrackerCollection];
    }
    return habitTrackerCollection;
  }
}
