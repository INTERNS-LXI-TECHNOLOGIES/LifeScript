import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';

import { IHabitTrack } from '../habit-track.model';
import { sampleWithFullData, sampleWithNewData, sampleWithPartialData, sampleWithRequiredData } from '../habit-track.test-samples';

import { HabitTrackService } from './habit-track.service';

const requireRestSample: IHabitTrack = {
  ...sampleWithRequiredData,
};

describe('HabitTrack Service', () => {
  let service: HabitTrackService;
  let httpMock: HttpTestingController;
  let expectedResult: IHabitTrack | IHabitTrack[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()],
    });
    expectedResult = null;
    service = TestBed.inject(HabitTrackService);
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

    it('should create a HabitTrack', () => {
      const habitTrack = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(habitTrack).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a HabitTrack', () => {
      const habitTrack = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(habitTrack).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a HabitTrack', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of HabitTrack', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a HabitTrack', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addHabitTrackToCollectionIfMissing', () => {
      it('should add a HabitTrack to an empty array', () => {
        const habitTrack: IHabitTrack = sampleWithRequiredData;
        expectedResult = service.addHabitTrackToCollectionIfMissing([], habitTrack);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(habitTrack);
      });

      it('should not add a HabitTrack to an array that contains it', () => {
        const habitTrack: IHabitTrack = sampleWithRequiredData;
        const habitTrackCollection: IHabitTrack[] = [
          {
            ...habitTrack,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addHabitTrackToCollectionIfMissing(habitTrackCollection, habitTrack);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a HabitTrack to an array that doesn't contain it", () => {
        const habitTrack: IHabitTrack = sampleWithRequiredData;
        const habitTrackCollection: IHabitTrack[] = [sampleWithPartialData];
        expectedResult = service.addHabitTrackToCollectionIfMissing(habitTrackCollection, habitTrack);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(habitTrack);
      });

      it('should add only unique HabitTrack to an array', () => {
        const habitTrackArray: IHabitTrack[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const habitTrackCollection: IHabitTrack[] = [sampleWithRequiredData];
        expectedResult = service.addHabitTrackToCollectionIfMissing(habitTrackCollection, ...habitTrackArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const habitTrack: IHabitTrack = sampleWithRequiredData;
        const habitTrack2: IHabitTrack = sampleWithPartialData;
        expectedResult = service.addHabitTrackToCollectionIfMissing([], habitTrack, habitTrack2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(habitTrack);
        expect(expectedResult).toContain(habitTrack2);
      });

      it('should accept null and undefined values', () => {
        const habitTrack: IHabitTrack = sampleWithRequiredData;
        expectedResult = service.addHabitTrackToCollectionIfMissing([], null, habitTrack, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(habitTrack);
      });

      it('should return initial array if no HabitTrack is added', () => {
        const habitTrackCollection: IHabitTrack[] = [sampleWithRequiredData];
        expectedResult = service.addHabitTrackToCollectionIfMissing(habitTrackCollection, undefined, null);
        expect(expectedResult).toEqual(habitTrackCollection);
      });
    });

    describe('compareHabitTrack', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareHabitTrack(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 21546 };
        const entity2 = null;

        const compareResult1 = service.compareHabitTrack(entity1, entity2);
        const compareResult2 = service.compareHabitTrack(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 21546 };
        const entity2 = { id: 32282 };

        const compareResult1 = service.compareHabitTrack(entity1, entity2);
        const compareResult2 = service.compareHabitTrack(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 21546 };
        const entity2 = { id: 21546 };

        const compareResult1 = service.compareHabitTrack(entity1, entity2);
        const compareResult2 = service.compareHabitTrack(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
