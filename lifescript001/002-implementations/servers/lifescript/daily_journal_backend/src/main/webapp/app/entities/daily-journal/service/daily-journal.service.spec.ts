import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';

import { DATE_FORMAT } from 'app/config/input.constants';
import { IDailyJournal } from '../daily-journal.model';
import { sampleWithRequiredData, sampleWithNewData, sampleWithPartialData, sampleWithFullData } from '../daily-journal.test-samples';

import { DailyJournalService, RestDailyJournal } from './daily-journal.service';

const requireRestSample: RestDailyJournal = {
  ...sampleWithRequiredData,
  date: sampleWithRequiredData.date?.format(DATE_FORMAT),
};

describe('DailyJournal Service', () => {
  let service: DailyJournalService;
  let httpMock: HttpTestingController;
  let expectedResult: IDailyJournal | IDailyJournal[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
    });
    expectedResult = null;
    service = TestBed.inject(DailyJournalService);
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

    it('should create a DailyJournal', () => {
      const dailyJournal = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(dailyJournal).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a DailyJournal', () => {
      const dailyJournal = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(dailyJournal).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a DailyJournal', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of DailyJournal', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a DailyJournal', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addDailyJournalToCollectionIfMissing', () => {
      it('should add a DailyJournal to an empty array', () => {
        const dailyJournal: IDailyJournal = sampleWithRequiredData;
        expectedResult = service.addDailyJournalToCollectionIfMissing([], dailyJournal);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(dailyJournal);
      });

      it('should not add a DailyJournal to an array that contains it', () => {
        const dailyJournal: IDailyJournal = sampleWithRequiredData;
        const dailyJournalCollection: IDailyJournal[] = [
          {
            ...dailyJournal,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addDailyJournalToCollectionIfMissing(dailyJournalCollection, dailyJournal);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a DailyJournal to an array that doesn't contain it", () => {
        const dailyJournal: IDailyJournal = sampleWithRequiredData;
        const dailyJournalCollection: IDailyJournal[] = [sampleWithPartialData];
        expectedResult = service.addDailyJournalToCollectionIfMissing(dailyJournalCollection, dailyJournal);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(dailyJournal);
      });

      it('should add only unique DailyJournal to an array', () => {
        const dailyJournalArray: IDailyJournal[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const dailyJournalCollection: IDailyJournal[] = [sampleWithRequiredData];
        expectedResult = service.addDailyJournalToCollectionIfMissing(dailyJournalCollection, ...dailyJournalArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const dailyJournal: IDailyJournal = sampleWithRequiredData;
        const dailyJournal2: IDailyJournal = sampleWithPartialData;
        expectedResult = service.addDailyJournalToCollectionIfMissing([], dailyJournal, dailyJournal2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(dailyJournal);
        expect(expectedResult).toContain(dailyJournal2);
      });

      it('should accept null and undefined values', () => {
        const dailyJournal: IDailyJournal = sampleWithRequiredData;
        expectedResult = service.addDailyJournalToCollectionIfMissing([], null, dailyJournal, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(dailyJournal);
      });

      it('should return initial array if no DailyJournal is added', () => {
        const dailyJournalCollection: IDailyJournal[] = [sampleWithRequiredData];
        expectedResult = service.addDailyJournalToCollectionIfMissing(dailyJournalCollection, undefined, null);
        expect(expectedResult).toEqual(dailyJournalCollection);
      });
    });

    describe('compareDailyJournal', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareDailyJournal(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 123 };
        const entity2 = null;

        const compareResult1 = service.compareDailyJournal(entity1, entity2);
        const compareResult2 = service.compareDailyJournal(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 456 };

        const compareResult1 = service.compareDailyJournal(entity1, entity2);
        const compareResult2 = service.compareDailyJournal(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 123 };

        const compareResult1 = service.compareDailyJournal(entity1, entity2);
        const compareResult2 = service.compareDailyJournal(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
