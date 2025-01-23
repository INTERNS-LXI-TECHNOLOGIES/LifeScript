import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';

import { IHabitTracker } from '../habit-tracker.model';
import { sampleWithFullData, sampleWithNewData, sampleWithPartialData, sampleWithRequiredData } from '../habit-tracker.test-samples';

import { HabitTrackerService } from './habit-tracker.service';

const requireRestSample: IHabitTracker = {
  ...sampleWithRequiredData,
};

describe('HabitTracker Service', () => {
  let service: HabitTrackerService;
  let httpMock: HttpTestingController;
  let expectedResult: IHabitTracker | IHabitTracker[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()],
    });
    expectedResult = null;
    service = TestBed.inject(HabitTrackerService);
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

    it('should create a HabitTracker', () => {
      const habitTracker = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(habitTracker).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a HabitTracker', () => {
      const habitTracker = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(habitTracker).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a HabitTracker', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of HabitTracker', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a HabitTracker', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addHabitTrackerToCollectionIfMissing', () => {
      it('should add a HabitTracker to an empty array', () => {
        const habitTracker: IHabitTracker = sampleWithRequiredData;
        expectedResult = service.addHabitTrackerToCollectionIfMissing([], habitTracker);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(habitTracker);
      });

      it('should not add a HabitTracker to an array that contains it', () => {
        const habitTracker: IHabitTracker = sampleWithRequiredData;
        const habitTrackerCollection: IHabitTracker[] = [
          {
            ...habitTracker,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addHabitTrackerToCollectionIfMissing(habitTrackerCollection, habitTracker);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a HabitTracker to an array that doesn't contain it", () => {
        const habitTracker: IHabitTracker = sampleWithRequiredData;
        const habitTrackerCollection: IHabitTracker[] = [sampleWithPartialData];
        expectedResult = service.addHabitTrackerToCollectionIfMissing(habitTrackerCollection, habitTracker);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(habitTracker);
      });

      it('should add only unique HabitTracker to an array', () => {
        const habitTrackerArray: IHabitTracker[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const habitTrackerCollection: IHabitTracker[] = [sampleWithRequiredData];
        expectedResult = service.addHabitTrackerToCollectionIfMissing(habitTrackerCollection, ...habitTrackerArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const habitTracker: IHabitTracker = sampleWithRequiredData;
        const habitTracker2: IHabitTracker = sampleWithPartialData;
        expectedResult = service.addHabitTrackerToCollectionIfMissing([], habitTracker, habitTracker2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(habitTracker);
        expect(expectedResult).toContain(habitTracker2);
      });

      it('should accept null and undefined values', () => {
        const habitTracker: IHabitTracker = sampleWithRequiredData;
        expectedResult = service.addHabitTrackerToCollectionIfMissing([], null, habitTracker, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(habitTracker);
      });

      it('should return initial array if no HabitTracker is added', () => {
        const habitTrackerCollection: IHabitTracker[] = [sampleWithRequiredData];
        expectedResult = service.addHabitTrackerToCollectionIfMissing(habitTrackerCollection, undefined, null);
        expect(expectedResult).toEqual(habitTrackerCollection);
      });
    });

    describe('compareHabitTracker', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareHabitTracker(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 10647 };
        const entity2 = null;

        const compareResult1 = service.compareHabitTracker(entity1, entity2);
        const compareResult2 = service.compareHabitTracker(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 10647 };
        const entity2 = { id: 9673 };

        const compareResult1 = service.compareHabitTracker(entity1, entity2);
        const compareResult2 = service.compareHabitTracker(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 10647 };
        const entity2 = { id: 10647 };

        const compareResult1 = service.compareHabitTracker(entity1, entity2);
        const compareResult2 = service.compareHabitTracker(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
