import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';

import { IGeoFence } from '../geo-fence.model';
import { sampleWithFullData, sampleWithNewData, sampleWithPartialData, sampleWithRequiredData } from '../geo-fence.test-samples';

import { GeoFenceService } from './geo-fence.service';

const requireRestSample: IGeoFence = {
  ...sampleWithRequiredData,
};

describe('GeoFence Service', () => {
  let service: GeoFenceService;
  let httpMock: HttpTestingController;
  let expectedResult: IGeoFence | IGeoFence[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()],
    });
    expectedResult = null;
    service = TestBed.inject(GeoFenceService);
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

    it('should create a GeoFence', () => {
      const geoFence = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(geoFence).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a GeoFence', () => {
      const geoFence = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(geoFence).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a GeoFence', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of GeoFence', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a GeoFence', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addGeoFenceToCollectionIfMissing', () => {
      it('should add a GeoFence to an empty array', () => {
        const geoFence: IGeoFence = sampleWithRequiredData;
        expectedResult = service.addGeoFenceToCollectionIfMissing([], geoFence);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(geoFence);
      });

      it('should not add a GeoFence to an array that contains it', () => {
        const geoFence: IGeoFence = sampleWithRequiredData;
        const geoFenceCollection: IGeoFence[] = [
          {
            ...geoFence,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addGeoFenceToCollectionIfMissing(geoFenceCollection, geoFence);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a GeoFence to an array that doesn't contain it", () => {
        const geoFence: IGeoFence = sampleWithRequiredData;
        const geoFenceCollection: IGeoFence[] = [sampleWithPartialData];
        expectedResult = service.addGeoFenceToCollectionIfMissing(geoFenceCollection, geoFence);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(geoFence);
      });

      it('should add only unique GeoFence to an array', () => {
        const geoFenceArray: IGeoFence[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const geoFenceCollection: IGeoFence[] = [sampleWithRequiredData];
        expectedResult = service.addGeoFenceToCollectionIfMissing(geoFenceCollection, ...geoFenceArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const geoFence: IGeoFence = sampleWithRequiredData;
        const geoFence2: IGeoFence = sampleWithPartialData;
        expectedResult = service.addGeoFenceToCollectionIfMissing([], geoFence, geoFence2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(geoFence);
        expect(expectedResult).toContain(geoFence2);
      });

      it('should accept null and undefined values', () => {
        const geoFence: IGeoFence = sampleWithRequiredData;
        expectedResult = service.addGeoFenceToCollectionIfMissing([], null, geoFence, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(geoFence);
      });

      it('should return initial array if no GeoFence is added', () => {
        const geoFenceCollection: IGeoFence[] = [sampleWithRequiredData];
        expectedResult = service.addGeoFenceToCollectionIfMissing(geoFenceCollection, undefined, null);
        expect(expectedResult).toEqual(geoFenceCollection);
      });
    });

    describe('compareGeoFence', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareGeoFence(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 14261 };
        const entity2 = null;

        const compareResult1 = service.compareGeoFence(entity1, entity2);
        const compareResult2 = service.compareGeoFence(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 14261 };
        const entity2 = { id: 22663 };

        const compareResult1 = service.compareGeoFence(entity1, entity2);
        const compareResult2 = service.compareGeoFence(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 14261 };
        const entity2 = { id: 14261 };

        const compareResult1 = service.compareGeoFence(entity1, entity2);
        const compareResult2 = service.compareGeoFence(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
