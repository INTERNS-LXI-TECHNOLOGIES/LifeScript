import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';

import { DATE_FORMAT } from 'app/config/input.constants';
import { IPerfectDay } from '../perfect-day.model';
import { sampleWithFullData, sampleWithNewData, sampleWithPartialData, sampleWithRequiredData } from '../perfect-day.test-samples';

import { PerfectDayService, RestPerfectDay } from './perfect-day.service';

const requireRestSample: RestPerfectDay = {
  ...sampleWithRequiredData,
  date: sampleWithRequiredData.date?.format(DATE_FORMAT),
};

describe('PerfectDay Service', () => {
  let service: PerfectDayService;
  let httpMock: HttpTestingController;
  let expectedResult: IPerfectDay | IPerfectDay[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()],
    });
    expectedResult = null;
    service = TestBed.inject(PerfectDayService);
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

    it('should create a PerfectDay', () => {
      const perfectDay = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(perfectDay).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a PerfectDay', () => {
      const perfectDay = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(perfectDay).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a PerfectDay', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of PerfectDay', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a PerfectDay', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addPerfectDayToCollectionIfMissing', () => {
      it('should add a PerfectDay to an empty array', () => {
        const perfectDay: IPerfectDay = sampleWithRequiredData;
        expectedResult = service.addPerfectDayToCollectionIfMissing([], perfectDay);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(perfectDay);
      });

      it('should not add a PerfectDay to an array that contains it', () => {
        const perfectDay: IPerfectDay = sampleWithRequiredData;
        const perfectDayCollection: IPerfectDay[] = [
          {
            ...perfectDay,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addPerfectDayToCollectionIfMissing(perfectDayCollection, perfectDay);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a PerfectDay to an array that doesn't contain it", () => {
        const perfectDay: IPerfectDay = sampleWithRequiredData;
        const perfectDayCollection: IPerfectDay[] = [sampleWithPartialData];
        expectedResult = service.addPerfectDayToCollectionIfMissing(perfectDayCollection, perfectDay);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(perfectDay);
      });

      it('should add only unique PerfectDay to an array', () => {
        const perfectDayArray: IPerfectDay[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const perfectDayCollection: IPerfectDay[] = [sampleWithRequiredData];
        expectedResult = service.addPerfectDayToCollectionIfMissing(perfectDayCollection, ...perfectDayArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const perfectDay: IPerfectDay = sampleWithRequiredData;
        const perfectDay2: IPerfectDay = sampleWithPartialData;
        expectedResult = service.addPerfectDayToCollectionIfMissing([], perfectDay, perfectDay2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(perfectDay);
        expect(expectedResult).toContain(perfectDay2);
      });

      it('should accept null and undefined values', () => {
        const perfectDay: IPerfectDay = sampleWithRequiredData;
        expectedResult = service.addPerfectDayToCollectionIfMissing([], null, perfectDay, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(perfectDay);
      });

      it('should return initial array if no PerfectDay is added', () => {
        const perfectDayCollection: IPerfectDay[] = [sampleWithRequiredData];
        expectedResult = service.addPerfectDayToCollectionIfMissing(perfectDayCollection, undefined, null);
        expect(expectedResult).toEqual(perfectDayCollection);
      });
    });

    describe('comparePerfectDay', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.comparePerfectDay(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 28965 };
        const entity2 = null;

        const compareResult1 = service.comparePerfectDay(entity1, entity2);
        const compareResult2 = service.comparePerfectDay(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 28965 };
        const entity2 = { id: 21128 };

        const compareResult1 = service.comparePerfectDay(entity1, entity2);
        const compareResult2 = service.comparePerfectDay(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 28965 };
        const entity2 = { id: 28965 };

        const compareResult1 = service.comparePerfectDay(entity1, entity2);
        const compareResult2 = service.comparePerfectDay(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
