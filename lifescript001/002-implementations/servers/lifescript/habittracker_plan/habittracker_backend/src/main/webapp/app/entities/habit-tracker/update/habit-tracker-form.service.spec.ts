import { TestBed } from '@angular/core/testing';

import { sampleWithNewData, sampleWithRequiredData } from '../habit-tracker.test-samples';

import { HabitTrackerFormService } from './habit-tracker-form.service';

describe('HabitTracker Form Service', () => {
  let service: HabitTrackerFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(HabitTrackerFormService);
  });

  describe('Service methods', () => {
    describe('createHabitTrackerFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createHabitTrackerFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            habitId: expect.any(Object),
            habitName: expect.any(Object),
            description: expect.any(Object),
            startDate: expect.any(Object),
            endDate: expect.any(Object),
          }),
        );
      });

      it('passing IHabitTracker should create a new form with FormGroup', () => {
        const formGroup = service.createHabitTrackerFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            habitId: expect.any(Object),
            habitName: expect.any(Object),
            description: expect.any(Object),
            startDate: expect.any(Object),
            endDate: expect.any(Object),
          }),
        );
      });
    });

    describe('getHabitTracker', () => {
      it('should return NewHabitTracker for default HabitTracker initial value', () => {
        const formGroup = service.createHabitTrackerFormGroup(sampleWithNewData);

        const habitTracker = service.getHabitTracker(formGroup) as any;

        expect(habitTracker).toMatchObject(sampleWithNewData);
      });

      it('should return NewHabitTracker for empty HabitTracker initial value', () => {
        const formGroup = service.createHabitTrackerFormGroup();

        const habitTracker = service.getHabitTracker(formGroup) as any;

        expect(habitTracker).toMatchObject({});
      });

      it('should return IHabitTracker', () => {
        const formGroup = service.createHabitTrackerFormGroup(sampleWithRequiredData);

        const habitTracker = service.getHabitTracker(formGroup) as any;

        expect(habitTracker).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IHabitTracker should not enable id FormControl', () => {
        const formGroup = service.createHabitTrackerFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewHabitTracker should disable id FormControl', () => {
        const formGroup = service.createHabitTrackerFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
