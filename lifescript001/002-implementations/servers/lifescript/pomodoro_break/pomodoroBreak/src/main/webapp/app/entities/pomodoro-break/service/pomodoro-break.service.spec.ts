import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';

import { IPomodoroBreak } from '../pomodoro-break.model';
import { sampleWithFullData, sampleWithNewData, sampleWithPartialData, sampleWithRequiredData } from '../pomodoro-break.test-samples';

import { PomodoroBreakService, RestPomodoroBreak } from './pomodoro-break.service';

const requireRestSample: RestPomodoroBreak = {
  ...sampleWithRequiredData,
  dateOfPomodoro: sampleWithRequiredData.dateOfPomodoro?.toJSON(),
  timeOfPomodoroCreation: sampleWithRequiredData.timeOfPomodoroCreation?.toJSON(),
};

describe('PomodoroBreak Service', () => {
  let service: PomodoroBreakService;
  let httpMock: HttpTestingController;
  let expectedResult: IPomodoroBreak | IPomodoroBreak[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()],
    });
    expectedResult = null;
    service = TestBed.inject(PomodoroBreakService);
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

    it('should create a PomodoroBreak', () => {
      const pomodoroBreak = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(pomodoroBreak).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a PomodoroBreak', () => {
      const pomodoroBreak = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(pomodoroBreak).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a PomodoroBreak', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of PomodoroBreak', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a PomodoroBreak', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addPomodoroBreakToCollectionIfMissing', () => {
      it('should add a PomodoroBreak to an empty array', () => {
        const pomodoroBreak: IPomodoroBreak = sampleWithRequiredData;
        expectedResult = service.addPomodoroBreakToCollectionIfMissing([], pomodoroBreak);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(pomodoroBreak);
      });

      it('should not add a PomodoroBreak to an array that contains it', () => {
        const pomodoroBreak: IPomodoroBreak = sampleWithRequiredData;
        const pomodoroBreakCollection: IPomodoroBreak[] = [
          {
            ...pomodoroBreak,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addPomodoroBreakToCollectionIfMissing(pomodoroBreakCollection, pomodoroBreak);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a PomodoroBreak to an array that doesn't contain it", () => {
        const pomodoroBreak: IPomodoroBreak = sampleWithRequiredData;
        const pomodoroBreakCollection: IPomodoroBreak[] = [sampleWithPartialData];
        expectedResult = service.addPomodoroBreakToCollectionIfMissing(pomodoroBreakCollection, pomodoroBreak);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(pomodoroBreak);
      });

      it('should add only unique PomodoroBreak to an array', () => {
        const pomodoroBreakArray: IPomodoroBreak[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const pomodoroBreakCollection: IPomodoroBreak[] = [sampleWithRequiredData];
        expectedResult = service.addPomodoroBreakToCollectionIfMissing(pomodoroBreakCollection, ...pomodoroBreakArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const pomodoroBreak: IPomodoroBreak = sampleWithRequiredData;
        const pomodoroBreak2: IPomodoroBreak = sampleWithPartialData;
        expectedResult = service.addPomodoroBreakToCollectionIfMissing([], pomodoroBreak, pomodoroBreak2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(pomodoroBreak);
        expect(expectedResult).toContain(pomodoroBreak2);
      });

      it('should accept null and undefined values', () => {
        const pomodoroBreak: IPomodoroBreak = sampleWithRequiredData;
        expectedResult = service.addPomodoroBreakToCollectionIfMissing([], null, pomodoroBreak, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(pomodoroBreak);
      });

      it('should return initial array if no PomodoroBreak is added', () => {
        const pomodoroBreakCollection: IPomodoroBreak[] = [sampleWithRequiredData];
        expectedResult = service.addPomodoroBreakToCollectionIfMissing(pomodoroBreakCollection, undefined, null);
        expect(expectedResult).toEqual(pomodoroBreakCollection);
      });
    });

    describe('comparePomodoroBreak', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.comparePomodoroBreak(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 1428 };
        const entity2 = null;

        const compareResult1 = service.comparePomodoroBreak(entity1, entity2);
        const compareResult2 = service.comparePomodoroBreak(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 1428 };
        const entity2 = { id: 30212 };

        const compareResult1 = service.comparePomodoroBreak(entity1, entity2);
        const compareResult2 = service.comparePomodoroBreak(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 1428 };
        const entity2 = { id: 1428 };

        const compareResult1 = service.comparePomodoroBreak(entity1, entity2);
        const compareResult2 = service.comparePomodoroBreak(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
