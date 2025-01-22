import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';

import { IDemo } from '../demo.model';
import { sampleWithFullData, sampleWithNewData, sampleWithPartialData, sampleWithRequiredData } from '../demo.test-samples';

import { DemoService } from './demo.service';

const requireRestSample: IDemo = {
  ...sampleWithRequiredData,
};

describe('Demo Service', () => {
  let service: DemoService;
  let httpMock: HttpTestingController;
  let expectedResult: IDemo | IDemo[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()],
    });
    expectedResult = null;
    service = TestBed.inject(DemoService);
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

    it('should create a Demo', () => {
      const demo = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(demo).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a Demo', () => {
      const demo = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(demo).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a Demo', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of Demo', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a Demo', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addDemoToCollectionIfMissing', () => {
      it('should add a Demo to an empty array', () => {
        const demo: IDemo = sampleWithRequiredData;
        expectedResult = service.addDemoToCollectionIfMissing([], demo);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(demo);
      });

      it('should not add a Demo to an array that contains it', () => {
        const demo: IDemo = sampleWithRequiredData;
        const demoCollection: IDemo[] = [
          {
            ...demo,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addDemoToCollectionIfMissing(demoCollection, demo);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a Demo to an array that doesn't contain it", () => {
        const demo: IDemo = sampleWithRequiredData;
        const demoCollection: IDemo[] = [sampleWithPartialData];
        expectedResult = service.addDemoToCollectionIfMissing(demoCollection, demo);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(demo);
      });

      it('should add only unique Demo to an array', () => {
        const demoArray: IDemo[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const demoCollection: IDemo[] = [sampleWithRequiredData];
        expectedResult = service.addDemoToCollectionIfMissing(demoCollection, ...demoArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const demo: IDemo = sampleWithRequiredData;
        const demo2: IDemo = sampleWithPartialData;
        expectedResult = service.addDemoToCollectionIfMissing([], demo, demo2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(demo);
        expect(expectedResult).toContain(demo2);
      });

      it('should accept null and undefined values', () => {
        const demo: IDemo = sampleWithRequiredData;
        expectedResult = service.addDemoToCollectionIfMissing([], null, demo, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(demo);
      });

      it('should return initial array if no Demo is added', () => {
        const demoCollection: IDemo[] = [sampleWithRequiredData];
        expectedResult = service.addDemoToCollectionIfMissing(demoCollection, undefined, null);
        expect(expectedResult).toEqual(demoCollection);
      });
    });

    describe('compareDemo', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareDemo(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 29057 };
        const entity2 = null;

        const compareResult1 = service.compareDemo(entity1, entity2);
        const compareResult2 = service.compareDemo(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 29057 };
        const entity2 = { id: 32133 };

        const compareResult1 = service.compareDemo(entity1, entity2);
        const compareResult2 = service.compareDemo(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 29057 };
        const entity2 = { id: 29057 };

        const compareResult1 = service.compareDemo(entity1, entity2);
        const compareResult2 = service.compareDemo(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
