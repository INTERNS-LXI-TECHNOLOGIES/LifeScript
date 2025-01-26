import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable, map } from 'rxjs';

import dayjs from 'dayjs/esm';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IMediaContent, NewMediaContent } from '../media-content.model';

export type PartialUpdateMediaContent = Partial<IMediaContent> & Pick<IMediaContent, 'id'>;

type RestOf<T extends IMediaContent | NewMediaContent> = Omit<T, 'uploadDateTime'> & {
  uploadDateTime?: string | null;
};

export type RestMediaContent = RestOf<IMediaContent>;

export type NewRestMediaContent = RestOf<NewMediaContent>;

export type PartialUpdateRestMediaContent = RestOf<PartialUpdateMediaContent>;

export type EntityResponseType = HttpResponse<IMediaContent>;
export type EntityArrayResponseType = HttpResponse<IMediaContent[]>;

@Injectable({ providedIn: 'root' })
export class MediaContentService {
  protected readonly http = inject(HttpClient);
  protected readonly applicationConfigService = inject(ApplicationConfigService);

  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/media-contents');

  create(mediaContent: NewMediaContent): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(mediaContent);
    return this.http
      .post<RestMediaContent>(this.resourceUrl, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  update(mediaContent: IMediaContent): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(mediaContent);
    return this.http
      .put<RestMediaContent>(`${this.resourceUrl}/${this.getMediaContentIdentifier(mediaContent)}`, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  partialUpdate(mediaContent: PartialUpdateMediaContent): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(mediaContent);
    return this.http
      .patch<RestMediaContent>(`${this.resourceUrl}/${this.getMediaContentIdentifier(mediaContent)}`, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http
      .get<RestMediaContent>(`${this.resourceUrl}/${id}`, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http
      .get<RestMediaContent[]>(this.resourceUrl, { params: options, observe: 'response' })
      .pipe(map(res => this.convertResponseArrayFromServer(res)));
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getMediaContentIdentifier(mediaContent: Pick<IMediaContent, 'id'>): number {
    return mediaContent.id;
  }

  compareMediaContent(o1: Pick<IMediaContent, 'id'> | null, o2: Pick<IMediaContent, 'id'> | null): boolean {
    return o1 && o2 ? this.getMediaContentIdentifier(o1) === this.getMediaContentIdentifier(o2) : o1 === o2;
  }

  addMediaContentToCollectionIfMissing<Type extends Pick<IMediaContent, 'id'>>(
    mediaContentCollection: Type[],
    ...mediaContentsToCheck: (Type | null | undefined)[]
  ): Type[] {
    const mediaContents: Type[] = mediaContentsToCheck.filter(isPresent);
    if (mediaContents.length > 0) {
      const mediaContentCollectionIdentifiers = mediaContentCollection.map(mediaContentItem =>
        this.getMediaContentIdentifier(mediaContentItem),
      );
      const mediaContentsToAdd = mediaContents.filter(mediaContentItem => {
        const mediaContentIdentifier = this.getMediaContentIdentifier(mediaContentItem);
        if (mediaContentCollectionIdentifiers.includes(mediaContentIdentifier)) {
          return false;
        }
        mediaContentCollectionIdentifiers.push(mediaContentIdentifier);
        return true;
      });
      return [...mediaContentsToAdd, ...mediaContentCollection];
    }
    return mediaContentCollection;
  }

  protected convertDateFromClient<T extends IMediaContent | NewMediaContent | PartialUpdateMediaContent>(mediaContent: T): RestOf<T> {
    return {
      ...mediaContent,
      uploadDateTime: mediaContent.uploadDateTime?.toJSON() ?? null,
    };
  }

  protected convertDateFromServer(restMediaContent: RestMediaContent): IMediaContent {
    return {
      ...restMediaContent,
      uploadDateTime: restMediaContent.uploadDateTime ? dayjs(restMediaContent.uploadDateTime) : undefined,
    };
  }

  protected convertResponseFromServer(res: HttpResponse<RestMediaContent>): HttpResponse<IMediaContent> {
    return res.clone({
      body: res.body ? this.convertDateFromServer(res.body) : null,
    });
  }

  protected convertResponseArrayFromServer(res: HttpResponse<RestMediaContent[]>): HttpResponse<IMediaContent[]> {
    return res.clone({
      body: res.body ? res.body.map(item => this.convertDateFromServer(item)) : null,
    });
  }
}
