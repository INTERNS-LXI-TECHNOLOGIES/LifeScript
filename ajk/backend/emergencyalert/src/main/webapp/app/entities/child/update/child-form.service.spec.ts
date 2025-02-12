import { TestBed } from '@angular/core/testing';

import { sampleWithNewData, sampleWithRequiredData } from '../child.test-samples';

import { ChildFormService } from './child-form.service';

describe('Child Form Service', () => {
  let service: ChildFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ChildFormService);
  });

  describe('Service methods', () => {
    describe('createChildFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createChildFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            name: expect.any(Object),
            age: expect.any(Object),
            emergencyContact: expect.any(Object),
            geoFence: expect.any(Object),
            batteryStatus: expect.any(Object),
            teacher: expect.any(Object),
            parent: expect.any(Object),
          }),
        );
      });

      it('passing IChild should create a new form with FormGroup', () => {
        const formGroup = service.createChildFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            name: expect.any(Object),
            age: expect.any(Object),
            emergencyContact: expect.any(Object),
            geoFence: expect.any(Object),
            batteryStatus: expect.any(Object),
            teacher: expect.any(Object),
            parent: expect.any(Object),
          }),
        );
      });
    });

    describe('getChild', () => {
      it('should return NewChild for default Child initial value', () => {
        const formGroup = service.createChildFormGroup(sampleWithNewData);

        const child = service.getChild(formGroup) as any;

        expect(child).toMatchObject(sampleWithNewData);
      });

      it('should return NewChild for empty Child initial value', () => {
        const formGroup = service.createChildFormGroup();

        const child = service.getChild(formGroup) as any;

        expect(child).toMatchObject({});
      });

      it('should return IChild', () => {
        const formGroup = service.createChildFormGroup(sampleWithRequiredData);

        const child = service.getChild(formGroup) as any;

        expect(child).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IChild should not enable id FormControl', () => {
        const formGroup = service.createChildFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewChild should disable id FormControl', () => {
        const formGroup = service.createChildFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
