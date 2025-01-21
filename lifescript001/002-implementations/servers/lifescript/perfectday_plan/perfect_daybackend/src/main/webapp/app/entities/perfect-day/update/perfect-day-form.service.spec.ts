import { TestBed } from '@angular/core/testing';

import { sampleWithNewData, sampleWithRequiredData } from '../perfect-day.test-samples';

import { PerfectDayFormService } from './perfect-day-form.service';

describe('PerfectDay Form Service', () => {
  let service: PerfectDayFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PerfectDayFormService);
  });

  describe('Service methods', () => {
    describe('createPerfectDayFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createPerfectDayFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            title: expect.any(Object),
            description: expect.any(Object),
            date: expect.any(Object),
          }),
        );
      });

      it('passing IPerfectDay should create a new form with FormGroup', () => {
        const formGroup = service.createPerfectDayFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            title: expect.any(Object),
            description: expect.any(Object),
            date: expect.any(Object),
          }),
        );
      });
    });

    describe('getPerfectDay', () => {
      it('should return NewPerfectDay for default PerfectDay initial value', () => {
        const formGroup = service.createPerfectDayFormGroup(sampleWithNewData);

        const perfectDay = service.getPerfectDay(formGroup) as any;

        expect(perfectDay).toMatchObject(sampleWithNewData);
      });

      it('should return NewPerfectDay for empty PerfectDay initial value', () => {
        const formGroup = service.createPerfectDayFormGroup();

        const perfectDay = service.getPerfectDay(formGroup) as any;

        expect(perfectDay).toMatchObject({});
      });

      it('should return IPerfectDay', () => {
        const formGroup = service.createPerfectDayFormGroup(sampleWithRequiredData);

        const perfectDay = service.getPerfectDay(formGroup) as any;

        expect(perfectDay).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IPerfectDay should not enable id FormControl', () => {
        const formGroup = service.createPerfectDayFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewPerfectDay should disable id FormControl', () => {
        const formGroup = service.createPerfectDayFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
