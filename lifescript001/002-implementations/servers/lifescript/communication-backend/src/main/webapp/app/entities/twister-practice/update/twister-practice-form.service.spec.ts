import { TestBed } from '@angular/core/testing';

import { sampleWithNewData, sampleWithRequiredData } from '../twister-practice.test-samples';

import { TwisterPracticeFormService } from './twister-practice-form.service';

describe('TwisterPractice Form Service', () => {
  let service: TwisterPracticeFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(TwisterPracticeFormService);
  });

  describe('Service methods', () => {
    describe('createTwisterPracticeFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createTwisterPracticeFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            score: expect.any(Object),
            timesPracticed: expect.any(Object),
            corrections: expect.any(Object),
            mediaContent: expect.any(Object),
          }),
        );
      });

      it('passing ITwisterPractice should create a new form with FormGroup', () => {
        const formGroup = service.createTwisterPracticeFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            score: expect.any(Object),
            timesPracticed: expect.any(Object),
            corrections: expect.any(Object),
            mediaContent: expect.any(Object),
          }),
        );
      });
    });

    describe('getTwisterPractice', () => {
      it('should return NewTwisterPractice for default TwisterPractice initial value', () => {
        const formGroup = service.createTwisterPracticeFormGroup(sampleWithNewData);

        const twisterPractice = service.getTwisterPractice(formGroup) as any;

        expect(twisterPractice).toMatchObject(sampleWithNewData);
      });

      it('should return NewTwisterPractice for empty TwisterPractice initial value', () => {
        const formGroup = service.createTwisterPracticeFormGroup();

        const twisterPractice = service.getTwisterPractice(formGroup) as any;

        expect(twisterPractice).toMatchObject({});
      });

      it('should return ITwisterPractice', () => {
        const formGroup = service.createTwisterPracticeFormGroup(sampleWithRequiredData);

        const twisterPractice = service.getTwisterPractice(formGroup) as any;

        expect(twisterPractice).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing ITwisterPractice should not enable id FormControl', () => {
        const formGroup = service.createTwisterPracticeFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewTwisterPractice should disable id FormControl', () => {
        const formGroup = service.createTwisterPracticeFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
