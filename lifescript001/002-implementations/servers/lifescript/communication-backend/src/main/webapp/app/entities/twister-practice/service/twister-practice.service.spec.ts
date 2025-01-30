import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';

import { ITwisterPractice } from '../twister-practice.model';
import { sampleWithFullData, sampleWithNewData, sampleWithPartialData, sampleWithRequiredData } from '../twister-practice.test-samples';

import { TwisterPracticeService } from './twister-practice.service';

const requireRestSample: ITwisterPractice = {
  ...sampleWithRequiredData,
};

describe('TwisterPractice Service', () => {
  let service: TwisterPracticeService;
  let httpMock: HttpTestingController;
  let expectedResult: ITwisterPractice | ITwisterPractice[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()],
    });
    expectedResult = null;
    service = TestBed.inject(TwisterPracticeService);
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

    it('should create a TwisterPractice', () => {
      const twisterPractice = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(twisterPractice).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a TwisterPractice', () => {
      const twisterPractice = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(twisterPractice).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a TwisterPractice', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of TwisterPractice', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a TwisterPractice', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addTwisterPracticeToCollectionIfMissing', () => {
      it('should add a TwisterPractice to an empty array', () => {
        const twisterPractice: ITwisterPractice = sampleWithRequiredData;
        expectedResult = service.addTwisterPracticeToCollectionIfMissing([], twisterPractice);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(twisterPractice);
      });

      it('should not add a TwisterPractice to an array that contains it', () => {
        const twisterPractice: ITwisterPractice = sampleWithRequiredData;
        const twisterPracticeCollection: ITwisterPractice[] = [
          {
            ...twisterPractice,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addTwisterPracticeToCollectionIfMissing(twisterPracticeCollection, twisterPractice);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a TwisterPractice to an array that doesn't contain it", () => {
        const twisterPractice: ITwisterPractice = sampleWithRequiredData;
        const twisterPracticeCollection: ITwisterPractice[] = [sampleWithPartialData];
        expectedResult = service.addTwisterPracticeToCollectionIfMissing(twisterPracticeCollection, twisterPractice);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(twisterPractice);
      });

      it('should add only unique TwisterPractice to an array', () => {
        const twisterPracticeArray: ITwisterPractice[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const twisterPracticeCollection: ITwisterPractice[] = [sampleWithRequiredData];
        expectedResult = service.addTwisterPracticeToCollectionIfMissing(twisterPracticeCollection, ...twisterPracticeArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const twisterPractice: ITwisterPractice = sampleWithRequiredData;
        const twisterPractice2: ITwisterPractice = sampleWithPartialData;
        expectedResult = service.addTwisterPracticeToCollectionIfMissing([], twisterPractice, twisterPractice2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(twisterPractice);
        expect(expectedResult).toContain(twisterPractice2);
      });

      it('should accept null and undefined values', () => {
        const twisterPractice: ITwisterPractice = sampleWithRequiredData;
        expectedResult = service.addTwisterPracticeToCollectionIfMissing([], null, twisterPractice, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(twisterPractice);
      });

      it('should return initial array if no TwisterPractice is added', () => {
        const twisterPracticeCollection: ITwisterPractice[] = [sampleWithRequiredData];
        expectedResult = service.addTwisterPracticeToCollectionIfMissing(twisterPracticeCollection, undefined, null);
        expect(expectedResult).toEqual(twisterPracticeCollection);
      });
    });

    describe('compareTwisterPractice', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareTwisterPractice(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 11105 };
        const entity2 = null;

        const compareResult1 = service.compareTwisterPractice(entity1, entity2);
        const compareResult2 = service.compareTwisterPractice(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 11105 };
        const entity2 = { id: 30383 };

        const compareResult1 = service.compareTwisterPractice(entity1, entity2);
        const compareResult2 = service.compareTwisterPractice(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 11105 };
        const entity2 = { id: 11105 };

        const compareResult1 = service.compareTwisterPractice(entity1, entity2);
        const compareResult2 = service.compareTwisterPractice(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
