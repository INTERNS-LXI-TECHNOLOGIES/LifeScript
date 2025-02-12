import { TestBed } from '@angular/core/testing';

import { sampleWithNewData, sampleWithRequiredData } from '../emergency-contact.test-samples';

import { EmergencyContactFormService } from './emergency-contact-form.service';

describe('EmergencyContact Form Service', () => {
  let service: EmergencyContactFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(EmergencyContactFormService);
  });

  describe('Service methods', () => {
    describe('createEmergencyContactFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createEmergencyContactFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            name: expect.any(Object),
            type: expect.any(Object),
            phoneNumber: expect.any(Object),
            parent: expect.any(Object),
          }),
        );
      });

      it('passing IEmergencyContact should create a new form with FormGroup', () => {
        const formGroup = service.createEmergencyContactFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            name: expect.any(Object),
            type: expect.any(Object),
            phoneNumber: expect.any(Object),
            parent: expect.any(Object),
          }),
        );
      });
    });

    describe('getEmergencyContact', () => {
      it('should return NewEmergencyContact for default EmergencyContact initial value', () => {
        const formGroup = service.createEmergencyContactFormGroup(sampleWithNewData);

        const emergencyContact = service.getEmergencyContact(formGroup) as any;

        expect(emergencyContact).toMatchObject(sampleWithNewData);
      });

      it('should return NewEmergencyContact for empty EmergencyContact initial value', () => {
        const formGroup = service.createEmergencyContactFormGroup();

        const emergencyContact = service.getEmergencyContact(formGroup) as any;

        expect(emergencyContact).toMatchObject({});
      });

      it('should return IEmergencyContact', () => {
        const formGroup = service.createEmergencyContactFormGroup(sampleWithRequiredData);

        const emergencyContact = service.getEmergencyContact(formGroup) as any;

        expect(emergencyContact).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IEmergencyContact should not enable id FormControl', () => {
        const formGroup = service.createEmergencyContactFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewEmergencyContact should disable id FormControl', () => {
        const formGroup = service.createEmergencyContactFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
