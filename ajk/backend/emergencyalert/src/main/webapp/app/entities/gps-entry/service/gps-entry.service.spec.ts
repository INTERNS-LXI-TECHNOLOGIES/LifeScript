import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';

import { IGpsEntry } from '../gps-entry.model';
import { sampleWithFullData, sampleWithNewData, sampleWithPartialData, sampleWithRequiredData } from '../gps-entry.test-samples';

import { GpsEntryService, RestGpsEntry } from './gps-entry.service';

const requireRestSample: RestGpsEntry = {
  ...sampleWithRequiredData,
  timestamp: sampleWithRequiredData.timestamp?.toJSON(),
};

describe('GpsEntry Service', () => {
  let service: GpsEntryService;
  let httpMock: HttpTestingController;
  let expectedResult: IGpsEntry | IGpsEntry[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()],
    });
    expectedResult = null;
    service = TestBed.inject(GpsEntryService);
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

    it('should create a GpsEntry', () => {
      const gpsEntry = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(gpsEntry).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a GpsEntry', () => {
      const gpsEntry = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(gpsEntry).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a GpsEntry', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of GpsEntry', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a GpsEntry', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addGpsEntryToCollectionIfMissing', () => {
      it('should add a GpsEntry to an empty array', () => {
        const gpsEntry: IGpsEntry = sampleWithRequiredData;
        expectedResult = service.addGpsEntryToCollectionIfMissing([], gpsEntry);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(gpsEntry);
      });

      it('should not add a GpsEntry to an array that contains it', () => {
        const gpsEntry: IGpsEntry = sampleWithRequiredData;
        const gpsEntryCollection: IGpsEntry[] = [
          {
            ...gpsEntry,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addGpsEntryToCollectionIfMissing(gpsEntryCollection, gpsEntry);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a GpsEntry to an array that doesn't contain it", () => {
        const gpsEntry: IGpsEntry = sampleWithRequiredData;
        const gpsEntryCollection: IGpsEntry[] = [sampleWithPartialData];
        expectedResult = service.addGpsEntryToCollectionIfMissing(gpsEntryCollection, gpsEntry);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(gpsEntry);
      });

      it('should add only unique GpsEntry to an array', () => {
        const gpsEntryArray: IGpsEntry[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const gpsEntryCollection: IGpsEntry[] = [sampleWithRequiredData];
        expectedResult = service.addGpsEntryToCollectionIfMissing(gpsEntryCollection, ...gpsEntryArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const gpsEntry: IGpsEntry = sampleWithRequiredData;
        const gpsEntry2: IGpsEntry = sampleWithPartialData;
        expectedResult = service.addGpsEntryToCollectionIfMissing([], gpsEntry, gpsEntry2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(gpsEntry);
        expect(expectedResult).toContain(gpsEntry2);
      });

      it('should accept null and undefined values', () => {
        const gpsEntry: IGpsEntry = sampleWithRequiredData;
        expectedResult = service.addGpsEntryToCollectionIfMissing([], null, gpsEntry, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(gpsEntry);
      });

      it('should return initial array if no GpsEntry is added', () => {
        const gpsEntryCollection: IGpsEntry[] = [sampleWithRequiredData];
        expectedResult = service.addGpsEntryToCollectionIfMissing(gpsEntryCollection, undefined, null);
        expect(expectedResult).toEqual(gpsEntryCollection);
      });
    });

    describe('compareGpsEntry', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareGpsEntry(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 18863 };
        const entity2 = null;

        const compareResult1 = service.compareGpsEntry(entity1, entity2);
        const compareResult2 = service.compareGpsEntry(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 18863 };
        const entity2 = { id: 27363 };

        const compareResult1 = service.compareGpsEntry(entity1, entity2);
        const compareResult2 = service.compareGpsEntry(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 18863 };
        const entity2 = { id: 18863 };

        const compareResult1 = service.compareGpsEntry(entity1, entity2);
        const compareResult2 = service.compareGpsEntry(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
