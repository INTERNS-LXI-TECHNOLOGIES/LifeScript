import { TestBed } from '@angular/core/testing';

import { sampleWithNewData, sampleWithRequiredData } from '../gps-entry.test-samples';

import { GpsEntryFormService } from './gps-entry-form.service';

describe('GpsEntry Form Service', () => {
  let service: GpsEntryFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(GpsEntryFormService);
  });

  describe('Service methods', () => {
    describe('createGpsEntryFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createGpsEntryFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            latitude: expect.any(Object),
            longitude: expect.any(Object),
            timestamp: expect.any(Object),
            deviceId: expect.any(Object),
            status: expect.any(Object),
            child: expect.any(Object),
          }),
        );
      });

      it('passing IGpsEntry should create a new form with FormGroup', () => {
        const formGroup = service.createGpsEntryFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            latitude: expect.any(Object),
            longitude: expect.any(Object),
            timestamp: expect.any(Object),
            deviceId: expect.any(Object),
            status: expect.any(Object),
            child: expect.any(Object),
          }),
        );
      });
    });

    describe('getGpsEntry', () => {
      it('should return NewGpsEntry for default GpsEntry initial value', () => {
        const formGroup = service.createGpsEntryFormGroup(sampleWithNewData);

        const gpsEntry = service.getGpsEntry(formGroup) as any;

        expect(gpsEntry).toMatchObject(sampleWithNewData);
      });

      it('should return NewGpsEntry for empty GpsEntry initial value', () => {
        const formGroup = service.createGpsEntryFormGroup();

        const gpsEntry = service.getGpsEntry(formGroup) as any;

        expect(gpsEntry).toMatchObject({});
      });

      it('should return IGpsEntry', () => {
        const formGroup = service.createGpsEntryFormGroup(sampleWithRequiredData);

        const gpsEntry = service.getGpsEntry(formGroup) as any;

        expect(gpsEntry).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IGpsEntry should not enable id FormControl', () => {
        const formGroup = service.createGpsEntryFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewGpsEntry should disable id FormControl', () => {
        const formGroup = service.createGpsEntryFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
