import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IHabitTrack, NewHabitTrack } from '../habit-track.model';

export type PartialUpdateHabitTrack = Partial<IHabitTrack> & Pick<IHabitTrack, 'id'>;

export type EntityResponseType = HttpResponse<IHabitTrack>;
export type EntityArrayResponseType = HttpResponse<IHabitTrack[]>;

@Injectable({ providedIn: 'root' })
export class HabitTrackService {
  protected readonly http = inject(HttpClient);
  protected readonly applicationConfigService = inject(ApplicationConfigService);

  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/habit-tracks');

  create(habitTrack: NewHabitTrack): Observable<EntityResponseType> {
    return this.http.post<IHabitTrack>(this.resourceUrl, habitTrack, { observe: 'response' });
  }

  update(habitTrack: IHabitTrack): Observable<EntityResponseType> {
    return this.http.put<IHabitTrack>(`${this.resourceUrl}/${this.getHabitTrackIdentifier(habitTrack)}`, habitTrack, {
      observe: 'response',
    });
  }

  partialUpdate(habitTrack: PartialUpdateHabitTrack): Observable<EntityResponseType> {
    return this.http.patch<IHabitTrack>(`${this.resourceUrl}/${this.getHabitTrackIdentifier(habitTrack)}`, habitTrack, {
      observe: 'response',
    });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IHabitTrack>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IHabitTrack[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getHabitTrackIdentifier(habitTrack: Pick<IHabitTrack, 'id'>): number {
    return habitTrack.id;
  }

  compareHabitTrack(o1: Pick<IHabitTrack, 'id'> | null, o2: Pick<IHabitTrack, 'id'> | null): boolean {
    return o1 && o2 ? this.getHabitTrackIdentifier(o1) === this.getHabitTrackIdentifier(o2) : o1 === o2;
  }

  addHabitTrackToCollectionIfMissing<Type extends Pick<IHabitTrack, 'id'>>(
    habitTrackCollection: Type[],
    ...habitTracksToCheck: (Type | null | undefined)[]
  ): Type[] {
    const habitTracks: Type[] = habitTracksToCheck.filter(isPresent);
    if (habitTracks.length > 0) {
      const habitTrackCollectionIdentifiers = habitTrackCollection.map(habitTrackItem => this.getHabitTrackIdentifier(habitTrackItem));
      const habitTracksToAdd = habitTracks.filter(habitTrackItem => {
        const habitTrackIdentifier = this.getHabitTrackIdentifier(habitTrackItem);
        if (habitTrackCollectionIdentifiers.includes(habitTrackIdentifier)) {
          return false;
        }
        habitTrackCollectionIdentifiers.push(habitTrackIdentifier);
        return true;
      });
      return [...habitTracksToAdd, ...habitTrackCollection];
    }
    return habitTrackCollection;
  }
}
