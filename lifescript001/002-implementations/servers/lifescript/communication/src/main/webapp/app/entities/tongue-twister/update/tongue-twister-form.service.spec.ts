import { TestBed } from '@angular/core/testing';

import { sampleWithNewData, sampleWithRequiredData } from '../tongue-twister.test-samples';

import { TongueTwisterFormService } from './tongue-twister-form.service';

describe('TongueTwister Form Service', () => {
  let service: TongueTwisterFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(TongueTwisterFormService);
  });

  describe('Service methods', () => {
    describe('createTongueTwisterFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createTongueTwisterFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            text: expect.any(Object),
            language: expect.any(Object),
            difficultyLevel: expect.any(Object),
            creator: expect.any(Object),
          }),
        );
      });

      it('passing ITongueTwister should create a new form with FormGroup', () => {
        const formGroup = service.createTongueTwisterFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            text: expect.any(Object),
            language: expect.any(Object),
            difficultyLevel: expect.any(Object),
            creator: expect.any(Object),
          }),
        );
      });
    });

    describe('getTongueTwister', () => {
      it('should return NewTongueTwister for default TongueTwister initial value', () => {
        const formGroup = service.createTongueTwisterFormGroup(sampleWithNewData);

        const tongueTwister = service.getTongueTwister(formGroup) as any;

        expect(tongueTwister).toMatchObject(sampleWithNewData);
      });

      it('should return NewTongueTwister for empty TongueTwister initial value', () => {
        const formGroup = service.createTongueTwisterFormGroup();

        const tongueTwister = service.getTongueTwister(formGroup) as any;

        expect(tongueTwister).toMatchObject({});
      });

      it('should return ITongueTwister', () => {
        const formGroup = service.createTongueTwisterFormGroup(sampleWithRequiredData);

        const tongueTwister = service.getTongueTwister(formGroup) as any;

        expect(tongueTwister).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing ITongueTwister should not enable id FormControl', () => {
        const formGroup = service.createTongueTwisterFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewTongueTwister should disable id FormControl', () => {
        const formGroup = service.createTongueTwisterFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
