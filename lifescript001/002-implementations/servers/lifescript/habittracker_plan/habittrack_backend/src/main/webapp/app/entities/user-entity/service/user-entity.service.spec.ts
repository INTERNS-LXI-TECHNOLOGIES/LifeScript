import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';

import { IUserEntity } from '../user-entity.model';
import { sampleWithFullData, sampleWithNewData, sampleWithPartialData, sampleWithRequiredData } from '../user-entity.test-samples';

import { UserEntityService } from './user-entity.service';

const requireRestSample: IUserEntity = {
  ...sampleWithRequiredData,
};

describe('UserEntity Service', () => {
  let service: UserEntityService;
  let httpMock: HttpTestingController;
  let expectedResult: IUserEntity | IUserEntity[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()],
    });
    expectedResult = null;
    service = TestBed.inject(UserEntityService);
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

    it('should create a UserEntity', () => {
      const userEntity = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(userEntity).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a UserEntity', () => {
      const userEntity = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(userEntity).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a UserEntity', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of UserEntity', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a UserEntity', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addUserEntityToCollectionIfMissing', () => {
      it('should add a UserEntity to an empty array', () => {
        const userEntity: IUserEntity = sampleWithRequiredData;
        expectedResult = service.addUserEntityToCollectionIfMissing([], userEntity);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(userEntity);
      });

      it('should not add a UserEntity to an array that contains it', () => {
        const userEntity: IUserEntity = sampleWithRequiredData;
        const userEntityCollection: IUserEntity[] = [
          {
            ...userEntity,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addUserEntityToCollectionIfMissing(userEntityCollection, userEntity);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a UserEntity to an array that doesn't contain it", () => {
        const userEntity: IUserEntity = sampleWithRequiredData;
        const userEntityCollection: IUserEntity[] = [sampleWithPartialData];
        expectedResult = service.addUserEntityToCollectionIfMissing(userEntityCollection, userEntity);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(userEntity);
      });

      it('should add only unique UserEntity to an array', () => {
        const userEntityArray: IUserEntity[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const userEntityCollection: IUserEntity[] = [sampleWithRequiredData];
        expectedResult = service.addUserEntityToCollectionIfMissing(userEntityCollection, ...userEntityArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const userEntity: IUserEntity = sampleWithRequiredData;
        const userEntity2: IUserEntity = sampleWithPartialData;
        expectedResult = service.addUserEntityToCollectionIfMissing([], userEntity, userEntity2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(userEntity);
        expect(expectedResult).toContain(userEntity2);
      });

      it('should accept null and undefined values', () => {
        const userEntity: IUserEntity = sampleWithRequiredData;
        expectedResult = service.addUserEntityToCollectionIfMissing([], null, userEntity, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(userEntity);
      });

      it('should return initial array if no UserEntity is added', () => {
        const userEntityCollection: IUserEntity[] = [sampleWithRequiredData];
        expectedResult = service.addUserEntityToCollectionIfMissing(userEntityCollection, undefined, null);
        expect(expectedResult).toEqual(userEntityCollection);
      });
    });

    describe('compareUserEntity', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareUserEntity(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 27146 };
        const entity2 = null;

        const compareResult1 = service.compareUserEntity(entity1, entity2);
        const compareResult2 = service.compareUserEntity(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 27146 };
        const entity2 = { id: 25078 };

        const compareResult1 = service.compareUserEntity(entity1, entity2);
        const compareResult2 = service.compareUserEntity(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 27146 };
        const entity2 = { id: 27146 };

        const compareResult1 = service.compareUserEntity(entity1, entity2);
        const compareResult2 = service.compareUserEntity(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
