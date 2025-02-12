import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';

import { IEmergencyContact } from '../emergency-contact.model';
import { sampleWithFullData, sampleWithNewData, sampleWithPartialData, sampleWithRequiredData } from '../emergency-contact.test-samples';

import { EmergencyContactService } from './emergency-contact.service';

const requireRestSample: IEmergencyContact = {
  ...sampleWithRequiredData,
};

describe('EmergencyContact Service', () => {
  let service: EmergencyContactService;
  let httpMock: HttpTestingController;
  let expectedResult: IEmergencyContact | IEmergencyContact[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()],
    });
    expectedResult = null;
    service = TestBed.inject(EmergencyContactService);
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

    it('should create a EmergencyContact', () => {
      const emergencyContact = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(emergencyContact).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a EmergencyContact', () => {
      const emergencyContact = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(emergencyContact).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a EmergencyContact', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of EmergencyContact', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a EmergencyContact', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addEmergencyContactToCollectionIfMissing', () => {
      it('should add a EmergencyContact to an empty array', () => {
        const emergencyContact: IEmergencyContact = sampleWithRequiredData;
        expectedResult = service.addEmergencyContactToCollectionIfMissing([], emergencyContact);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(emergencyContact);
      });

      it('should not add a EmergencyContact to an array that contains it', () => {
        const emergencyContact: IEmergencyContact = sampleWithRequiredData;
        const emergencyContactCollection: IEmergencyContact[] = [
          {
            ...emergencyContact,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addEmergencyContactToCollectionIfMissing(emergencyContactCollection, emergencyContact);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a EmergencyContact to an array that doesn't contain it", () => {
        const emergencyContact: IEmergencyContact = sampleWithRequiredData;
        const emergencyContactCollection: IEmergencyContact[] = [sampleWithPartialData];
        expectedResult = service.addEmergencyContactToCollectionIfMissing(emergencyContactCollection, emergencyContact);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(emergencyContact);
      });

      it('should add only unique EmergencyContact to an array', () => {
        const emergencyContactArray: IEmergencyContact[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const emergencyContactCollection: IEmergencyContact[] = [sampleWithRequiredData];
        expectedResult = service.addEmergencyContactToCollectionIfMissing(emergencyContactCollection, ...emergencyContactArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const emergencyContact: IEmergencyContact = sampleWithRequiredData;
        const emergencyContact2: IEmergencyContact = sampleWithPartialData;
        expectedResult = service.addEmergencyContactToCollectionIfMissing([], emergencyContact, emergencyContact2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(emergencyContact);
        expect(expectedResult).toContain(emergencyContact2);
      });

      it('should accept null and undefined values', () => {
        const emergencyContact: IEmergencyContact = sampleWithRequiredData;
        expectedResult = service.addEmergencyContactToCollectionIfMissing([], null, emergencyContact, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(emergencyContact);
      });

      it('should return initial array if no EmergencyContact is added', () => {
        const emergencyContactCollection: IEmergencyContact[] = [sampleWithRequiredData];
        expectedResult = service.addEmergencyContactToCollectionIfMissing(emergencyContactCollection, undefined, null);
        expect(expectedResult).toEqual(emergencyContactCollection);
      });
    });

    describe('compareEmergencyContact', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareEmergencyContact(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 32648 };
        const entity2 = null;

        const compareResult1 = service.compareEmergencyContact(entity1, entity2);
        const compareResult2 = service.compareEmergencyContact(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 32648 };
        const entity2 = { id: 16332 };

        const compareResult1 = service.compareEmergencyContact(entity1, entity2);
        const compareResult2 = service.compareEmergencyContact(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 32648 };
        const entity2 = { id: 32648 };

        const compareResult1 = service.compareEmergencyContact(entity1, entity2);
        const compareResult2 = service.compareEmergencyContact(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
