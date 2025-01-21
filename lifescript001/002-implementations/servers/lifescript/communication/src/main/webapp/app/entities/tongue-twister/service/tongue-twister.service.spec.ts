import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';

import { ITongueTwister } from '../tongue-twister.model';
import { sampleWithFullData, sampleWithNewData, sampleWithPartialData, sampleWithRequiredData } from '../tongue-twister.test-samples';

import { TongueTwisterService } from './tongue-twister.service';

const requireRestSample: ITongueTwister = {
  ...sampleWithRequiredData,
};

describe('TongueTwister Service', () => {
  let service: TongueTwisterService;
  let httpMock: HttpTestingController;
  let expectedResult: ITongueTwister | ITongueTwister[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()],
    });
    expectedResult = null;
    service = TestBed.inject(TongueTwisterService);
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

    it('should create a TongueTwister', () => {
      const tongueTwister = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(tongueTwister).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a TongueTwister', () => {
      const tongueTwister = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(tongueTwister).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a TongueTwister', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of TongueTwister', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a TongueTwister', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addTongueTwisterToCollectionIfMissing', () => {
      it('should add a TongueTwister to an empty array', () => {
        const tongueTwister: ITongueTwister = sampleWithRequiredData;
        expectedResult = service.addTongueTwisterToCollectionIfMissing([], tongueTwister);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(tongueTwister);
      });

      it('should not add a TongueTwister to an array that contains it', () => {
        const tongueTwister: ITongueTwister = sampleWithRequiredData;
        const tongueTwisterCollection: ITongueTwister[] = [
          {
            ...tongueTwister,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addTongueTwisterToCollectionIfMissing(tongueTwisterCollection, tongueTwister);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a TongueTwister to an array that doesn't contain it", () => {
        const tongueTwister: ITongueTwister = sampleWithRequiredData;
        const tongueTwisterCollection: ITongueTwister[] = [sampleWithPartialData];
        expectedResult = service.addTongueTwisterToCollectionIfMissing(tongueTwisterCollection, tongueTwister);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(tongueTwister);
      });

      it('should add only unique TongueTwister to an array', () => {
        const tongueTwisterArray: ITongueTwister[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const tongueTwisterCollection: ITongueTwister[] = [sampleWithRequiredData];
        expectedResult = service.addTongueTwisterToCollectionIfMissing(tongueTwisterCollection, ...tongueTwisterArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const tongueTwister: ITongueTwister = sampleWithRequiredData;
        const tongueTwister2: ITongueTwister = sampleWithPartialData;
        expectedResult = service.addTongueTwisterToCollectionIfMissing([], tongueTwister, tongueTwister2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(tongueTwister);
        expect(expectedResult).toContain(tongueTwister2);
      });

      it('should accept null and undefined values', () => {
        const tongueTwister: ITongueTwister = sampleWithRequiredData;
        expectedResult = service.addTongueTwisterToCollectionIfMissing([], null, tongueTwister, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(tongueTwister);
      });

      it('should return initial array if no TongueTwister is added', () => {
        const tongueTwisterCollection: ITongueTwister[] = [sampleWithRequiredData];
        expectedResult = service.addTongueTwisterToCollectionIfMissing(tongueTwisterCollection, undefined, null);
        expect(expectedResult).toEqual(tongueTwisterCollection);
      });
    });

    describe('compareTongueTwister', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareTongueTwister(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 1199 };
        const entity2 = null;

        const compareResult1 = service.compareTongueTwister(entity1, entity2);
        const compareResult2 = service.compareTongueTwister(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 1199 };
        const entity2 = { id: 12635 };

        const compareResult1 = service.compareTongueTwister(entity1, entity2);
        const compareResult2 = service.compareTongueTwister(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 1199 };
        const entity2 = { id: 1199 };

        const compareResult1 = service.compareTongueTwister(entity1, entity2);
        const compareResult2 = service.compareTongueTwister(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
