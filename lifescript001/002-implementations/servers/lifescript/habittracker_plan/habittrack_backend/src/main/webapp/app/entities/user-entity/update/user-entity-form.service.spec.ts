import { TestBed } from '@angular/core/testing';

import { sampleWithNewData, sampleWithRequiredData } from '../user-entity.test-samples';

import { UserEntityFormService } from './user-entity-form.service';

describe('UserEntity Form Service', () => {
  let service: UserEntityFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(UserEntityFormService);
  });

  describe('Service methods', () => {
    describe('createUserEntityFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createUserEntityFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            userId: expect.any(Object),
            userName: expect.any(Object),
          }),
        );
      });

      it('passing IUserEntity should create a new form with FormGroup', () => {
        const formGroup = service.createUserEntityFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            userId: expect.any(Object),
            userName: expect.any(Object),
          }),
        );
      });
    });

    describe('getUserEntity', () => {
      it('should return NewUserEntity for default UserEntity initial value', () => {
        const formGroup = service.createUserEntityFormGroup(sampleWithNewData);

        const userEntity = service.getUserEntity(formGroup) as any;

        expect(userEntity).toMatchObject(sampleWithNewData);
      });

      it('should return NewUserEntity for empty UserEntity initial value', () => {
        const formGroup = service.createUserEntityFormGroup();

        const userEntity = service.getUserEntity(formGroup) as any;

        expect(userEntity).toMatchObject({});
      });

      it('should return IUserEntity', () => {
        const formGroup = service.createUserEntityFormGroup(sampleWithRequiredData);

        const userEntity = service.getUserEntity(formGroup) as any;

        expect(userEntity).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IUserEntity should not enable id FormControl', () => {
        const formGroup = service.createUserEntityFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewUserEntity should disable id FormControl', () => {
        const formGroup = service.createUserEntityFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
