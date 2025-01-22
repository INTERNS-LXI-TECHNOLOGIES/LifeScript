import { TestBed } from '@angular/core/testing';

import { sampleWithNewData, sampleWithRequiredData } from '../demo.test-samples';

import { DemoFormService } from './demo-form.service';

describe('Demo Form Service', () => {
  let service: DemoFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(DemoFormService);
  });

  describe('Service methods', () => {
    describe('createDemoFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createDemoFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            username: expect.any(Object),
            mobileNumber: expect.any(Object),
          }),
        );
      });

      it('passing IDemo should create a new form with FormGroup', () => {
        const formGroup = service.createDemoFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            username: expect.any(Object),
            mobileNumber: expect.any(Object),
          }),
        );
      });
    });

    describe('getDemo', () => {
      it('should return NewDemo for default Demo initial value', () => {
        const formGroup = service.createDemoFormGroup(sampleWithNewData);

        const demo = service.getDemo(formGroup) as any;

        expect(demo).toMatchObject(sampleWithNewData);
      });

      it('should return NewDemo for empty Demo initial value', () => {
        const formGroup = service.createDemoFormGroup();

        const demo = service.getDemo(formGroup) as any;

        expect(demo).toMatchObject({});
      });

      it('should return IDemo', () => {
        const formGroup = service.createDemoFormGroup(sampleWithRequiredData);

        const demo = service.getDemo(formGroup) as any;

        expect(demo).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IDemo should not enable id FormControl', () => {
        const formGroup = service.createDemoFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewDemo should disable id FormControl', () => {
        const formGroup = service.createDemoFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
