import { TestBed } from '@angular/core/testing';

import { sampleWithNewData, sampleWithRequiredData } from '../geo-fence.test-samples';

import { GeoFenceFormService } from './geo-fence-form.service';

describe('GeoFence Form Service', () => {
  let service: GeoFenceFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(GeoFenceFormService);
  });

  describe('Service methods', () => {
    describe('createGeoFenceFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createGeoFenceFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            safeZones: expect.any(Object),
          }),
        );
      });

      it('passing IGeoFence should create a new form with FormGroup', () => {
        const formGroup = service.createGeoFenceFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            safeZones: expect.any(Object),
          }),
        );
      });
    });

    describe('getGeoFence', () => {
      it('should return NewGeoFence for default GeoFence initial value', () => {
        const formGroup = service.createGeoFenceFormGroup(sampleWithNewData);

        const geoFence = service.getGeoFence(formGroup) as any;

        expect(geoFence).toMatchObject(sampleWithNewData);
      });

      it('should return NewGeoFence for empty GeoFence initial value', () => {
        const formGroup = service.createGeoFenceFormGroup();

        const geoFence = service.getGeoFence(formGroup) as any;

        expect(geoFence).toMatchObject({});
      });

      it('should return IGeoFence', () => {
        const formGroup = service.createGeoFenceFormGroup(sampleWithRequiredData);

        const geoFence = service.getGeoFence(formGroup) as any;

        expect(geoFence).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IGeoFence should not enable id FormControl', () => {
        const formGroup = service.createGeoFenceFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewGeoFence should disable id FormControl', () => {
        const formGroup = service.createGeoFenceFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
