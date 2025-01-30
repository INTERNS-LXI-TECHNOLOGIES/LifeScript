import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';

import { IMediaContent } from '../media-content.model';
import { sampleWithFullData, sampleWithNewData, sampleWithPartialData, sampleWithRequiredData } from '../media-content.test-samples';

import { MediaContentService, RestMediaContent } from './media-content.service';

const requireRestSample: RestMediaContent = {
  ...sampleWithRequiredData,
  uploadDateTime: sampleWithRequiredData.uploadDateTime?.toJSON(),
};

describe('MediaContent Service', () => {
  let service: MediaContentService;
  let httpMock: HttpTestingController;
  let expectedResult: IMediaContent | IMediaContent[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()],
    });
    expectedResult = null;
    service = TestBed.inject(MediaContentService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  describe('Service methods', () => {
    it('should find an element', () => {
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.find(123).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should create a MediaContent', () => {
      const mediaContent = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(mediaContent).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a MediaContent', () => {
      const mediaContent = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(mediaContent).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a MediaContent', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of MediaContent', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a MediaContent', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addMediaContentToCollectionIfMissing', () => {
      it('should add a MediaContent to an empty array', () => {
        const mediaContent: IMediaContent = sampleWithRequiredData;
        expectedResult = service.addMediaContentToCollectionIfMissing([], mediaContent);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(mediaContent);
      });

      it('should not add a MediaContent to an array that contains it', () => {
        const mediaContent: IMediaContent = sampleWithRequiredData;
        const mediaContentCollection: IMediaContent[] = [
          {
            ...mediaContent,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addMediaContentToCollectionIfMissing(mediaContentCollection, mediaContent);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a MediaContent to an array that doesn't contain it", () => {
        const mediaContent: IMediaContent = sampleWithRequiredData;
        const mediaContentCollection: IMediaContent[] = [sampleWithPartialData];
        expectedResult = service.addMediaContentToCollectionIfMissing(mediaContentCollection, mediaContent);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(mediaContent);
      });

      it('should add only unique MediaContent to an array', () => {
        const mediaContentArray: IMediaContent[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const mediaContentCollection: IMediaContent[] = [sampleWithRequiredData];
        expectedResult = service.addMediaContentToCollectionIfMissing(mediaContentCollection, ...mediaContentArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const mediaContent: IMediaContent = sampleWithRequiredData;
        const mediaContent2: IMediaContent = sampleWithPartialData;
        expectedResult = service.addMediaContentToCollectionIfMissing([], mediaContent, mediaContent2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(mediaContent);
        expect(expectedResult).toContain(mediaContent2);
      });

      it('should accept null and undefined values', () => {
        const mediaContent: IMediaContent = sampleWithRequiredData;
        expectedResult = service.addMediaContentToCollectionIfMissing([], null, mediaContent, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(mediaContent);
      });

      it('should return initial array if no MediaContent is added', () => {
        const mediaContentCollection: IMediaContent[] = [sampleWithRequiredData];
        expectedResult = service.addMediaContentToCollectionIfMissing(mediaContentCollection, undefined, null);
        expect(expectedResult).toEqual(mediaContentCollection);
      });
    });

    describe('compareMediaContent', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareMediaContent(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 31411 };
        const entity2 = null;

        const compareResult1 = service.compareMediaContent(entity1, entity2);
        const compareResult2 = service.compareMediaContent(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 31411 };
        const entity2 = { id: 11668 };

        const compareResult1 = service.compareMediaContent(entity1, entity2);
        const compareResult2 = service.compareMediaContent(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 31411 };
        const entity2 = { id: 31411 };

        const compareResult1 = service.compareMediaContent(entity1, entity2);
        const compareResult2 = service.compareMediaContent(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
