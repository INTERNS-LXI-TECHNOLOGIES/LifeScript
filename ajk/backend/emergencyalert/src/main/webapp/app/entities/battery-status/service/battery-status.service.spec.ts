import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';

import { IBatteryStatus } from '../battery-status.model';
import { sampleWithFullData, sampleWithNewData, sampleWithPartialData, sampleWithRequiredData } from '../battery-status.test-samples';

import { BatteryStatusService } from './battery-status.service';

const requireRestSample: IBatteryStatus = {
  ...sampleWithRequiredData,
};

describe('BatteryStatus Service', () => {
  let service: BatteryStatusService;
  let httpMock: HttpTestingController;
  let expectedResult: IBatteryStatus | IBatteryStatus[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()],
    });
    expectedResult = null;
    service = TestBed.inject(BatteryStatusService);
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

    it('should create a BatteryStatus', () => {
      const batteryStatus = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(batteryStatus).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a BatteryStatus', () => {
      const batteryStatus = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(batteryStatus).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a BatteryStatus', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of BatteryStatus', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a BatteryStatus', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addBatteryStatusToCollectionIfMissing', () => {
      it('should add a BatteryStatus to an empty array', () => {
        const batteryStatus: IBatteryStatus = sampleWithRequiredData;
        expectedResult = service.addBatteryStatusToCollectionIfMissing([], batteryStatus);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(batteryStatus);
      });

      it('should not add a BatteryStatus to an array that contains it', () => {
        const batteryStatus: IBatteryStatus = sampleWithRequiredData;
        const batteryStatusCollection: IBatteryStatus[] = [
          {
            ...batteryStatus,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addBatteryStatusToCollectionIfMissing(batteryStatusCollection, batteryStatus);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a BatteryStatus to an array that doesn't contain it", () => {
        const batteryStatus: IBatteryStatus = sampleWithRequiredData;
        const batteryStatusCollection: IBatteryStatus[] = [sampleWithPartialData];
        expectedResult = service.addBatteryStatusToCollectionIfMissing(batteryStatusCollection, batteryStatus);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(batteryStatus);
      });

      it('should add only unique BatteryStatus to an array', () => {
        const batteryStatusArray: IBatteryStatus[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const batteryStatusCollection: IBatteryStatus[] = [sampleWithRequiredData];
        expectedResult = service.addBatteryStatusToCollectionIfMissing(batteryStatusCollection, ...batteryStatusArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const batteryStatus: IBatteryStatus = sampleWithRequiredData;
        const batteryStatus2: IBatteryStatus = sampleWithPartialData;
        expectedResult = service.addBatteryStatusToCollectionIfMissing([], batteryStatus, batteryStatus2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(batteryStatus);
        expect(expectedResult).toContain(batteryStatus2);
      });

      it('should accept null and undefined values', () => {
        const batteryStatus: IBatteryStatus = sampleWithRequiredData;
        expectedResult = service.addBatteryStatusToCollectionIfMissing([], null, batteryStatus, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(batteryStatus);
      });

      it('should return initial array if no BatteryStatus is added', () => {
        const batteryStatusCollection: IBatteryStatus[] = [sampleWithRequiredData];
        expectedResult = service.addBatteryStatusToCollectionIfMissing(batteryStatusCollection, undefined, null);
        expect(expectedResult).toEqual(batteryStatusCollection);
      });
    });

    describe('compareBatteryStatus', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareBatteryStatus(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 20924 };
        const entity2 = null;

        const compareResult1 = service.compareBatteryStatus(entity1, entity2);
        const compareResult2 = service.compareBatteryStatus(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 20924 };
        const entity2 = { id: 22124 };

        const compareResult1 = service.compareBatteryStatus(entity1, entity2);
        const compareResult2 = service.compareBatteryStatus(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 20924 };
        const entity2 = { id: 20924 };

        const compareResult1 = service.compareBatteryStatus(entity1, entity2);
        const compareResult2 = service.compareBatteryStatus(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
