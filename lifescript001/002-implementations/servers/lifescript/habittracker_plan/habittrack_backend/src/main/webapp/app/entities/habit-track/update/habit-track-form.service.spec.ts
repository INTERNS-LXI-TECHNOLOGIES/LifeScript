import { TestBed } from '@angular/core/testing';

import { sampleWithNewData, sampleWithRequiredData } from '../habit-track.test-samples';

import { HabitTrackFormService } from './habit-track-form.service';

describe('HabitTrack Form Service', () => {
  let service: HabitTrackFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(HabitTrackFormService);
  });

  describe('Service methods', () => {
    describe('createHabitTrackFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createHabitTrackFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            habitId: expect.any(Object),
            habitName: expect.any(Object),
            description: expect.any(Object),
            category: expect.any(Object),
            startDate: expect.any(Object),
            endDate: expect.any(Object),
          }),
        );
      });

      it('passing IHabitTrack should create a new form with FormGroup', () => {
        const formGroup = service.createHabitTrackFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            habitId: expect.any(Object),
            habitName: expect.any(Object),
            description: expect.any(Object),
            category: expect.any(Object),
            startDate: expect.any(Object),
            endDate: expect.any(Object),
          }),
        );
      });
    });

    describe('getHabitTrack', () => {
      it('should return NewHabitTrack for default HabitTrack initial value', () => {
        const formGroup = service.createHabitTrackFormGroup(sampleWithNewData);

        const habitTrack = service.getHabitTrack(formGroup) as any;

        expect(habitTrack).toMatchObject(sampleWithNewData);
      });

      it('should return NewHabitTrack for empty HabitTrack initial value', () => {
        const formGroup = service.createHabitTrackFormGroup();

        const habitTrack = service.getHabitTrack(formGroup) as any;

        expect(habitTrack).toMatchObject({});
      });

      it('should return IHabitTrack', () => {
        const formGroup = service.createHabitTrackFormGroup(sampleWithRequiredData);

        const habitTrack = service.getHabitTrack(formGroup) as any;

        expect(habitTrack).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IHabitTrack should not enable id FormControl', () => {
        const formGroup = service.createHabitTrackFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewHabitTrack should disable id FormControl', () => {
        const formGroup = service.createHabitTrackFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
