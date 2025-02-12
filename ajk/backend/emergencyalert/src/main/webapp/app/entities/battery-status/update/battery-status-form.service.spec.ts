import { TestBed } from '@angular/core/testing';

import { sampleWithNewData, sampleWithRequiredData } from '../battery-status.test-samples';

import { BatteryStatusFormService } from './battery-status-form.service';

describe('BatteryStatus Form Service', () => {
  let service: BatteryStatusFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(BatteryStatusFormService);
  });

  describe('Service methods', () => {
    describe('createBatteryStatusFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createBatteryStatusFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            batteryLevel: expect.any(Object),
          }),
        );
      });

      it('passing IBatteryStatus should create a new form with FormGroup', () => {
        const formGroup = service.createBatteryStatusFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            batteryLevel: expect.any(Object),
          }),
        );
      });
    });

    describe('getBatteryStatus', () => {
      it('should return NewBatteryStatus for default BatteryStatus initial value', () => {
        const formGroup = service.createBatteryStatusFormGroup(sampleWithNewData);

        const batteryStatus = service.getBatteryStatus(formGroup) as any;

        expect(batteryStatus).toMatchObject(sampleWithNewData);
      });

      it('should return NewBatteryStatus for empty BatteryStatus initial value', () => {
        const formGroup = service.createBatteryStatusFormGroup();

        const batteryStatus = service.getBatteryStatus(formGroup) as any;

        expect(batteryStatus).toMatchObject({});
      });

      it('should return IBatteryStatus', () => {
        const formGroup = service.createBatteryStatusFormGroup(sampleWithRequiredData);

        const batteryStatus = service.getBatteryStatus(formGroup) as any;

        expect(batteryStatus).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IBatteryStatus should not enable id FormControl', () => {
        const formGroup = service.createBatteryStatusFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewBatteryStatus should disable id FormControl', () => {
        const formGroup = service.createBatteryStatusFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
