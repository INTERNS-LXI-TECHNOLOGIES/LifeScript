import { TestBed } from '@angular/core/testing';

import { sampleWithNewData, sampleWithRequiredData } from '../pomodoro-break.test-samples';

import { PomodoroBreakFormService } from './pomodoro-break-form.service';

describe('PomodoroBreak Form Service', () => {
  let service: PomodoroBreakFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PomodoroBreakFormService);
  });

  describe('Service methods', () => {
    describe('createPomodoroBreakFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createPomodoroBreakFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            userName: expect.any(Object),
            totalWorkingHour: expect.any(Object),
            dailyDurationOfWork: expect.any(Object),
            splitBreakDuration: expect.any(Object),
            breakDuration: expect.any(Object),
            completedBreaks: expect.any(Object),
            dateOfPomodoro: expect.any(Object),
            timeOfPomodoroCreation: expect.any(Object),
            notificationForBreak: expect.any(Object),
            finalMessage: expect.any(Object),
          }),
        );
      });

      it('passing IPomodoroBreak should create a new form with FormGroup', () => {
        const formGroup = service.createPomodoroBreakFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            userName: expect.any(Object),
            totalWorkingHour: expect.any(Object),
            dailyDurationOfWork: expect.any(Object),
            splitBreakDuration: expect.any(Object),
            breakDuration: expect.any(Object),
            completedBreaks: expect.any(Object),
            dateOfPomodoro: expect.any(Object),
            timeOfPomodoroCreation: expect.any(Object),
            notificationForBreak: expect.any(Object),
            finalMessage: expect.any(Object),
          }),
        );
      });
    });

    describe('getPomodoroBreak', () => {
      it('should return NewPomodoroBreak for default PomodoroBreak initial value', () => {
        const formGroup = service.createPomodoroBreakFormGroup(sampleWithNewData);

        const pomodoroBreak = service.getPomodoroBreak(formGroup) as any;

        expect(pomodoroBreak).toMatchObject(sampleWithNewData);
      });

      it('should return NewPomodoroBreak for empty PomodoroBreak initial value', () => {
        const formGroup = service.createPomodoroBreakFormGroup();

        const pomodoroBreak = service.getPomodoroBreak(formGroup) as any;

        expect(pomodoroBreak).toMatchObject({});
      });

      it('should return IPomodoroBreak', () => {
        const formGroup = service.createPomodoroBreakFormGroup(sampleWithRequiredData);

        const pomodoroBreak = service.getPomodoroBreak(formGroup) as any;

        expect(pomodoroBreak).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IPomodoroBreak should not enable id FormControl', () => {
        const formGroup = service.createPomodoroBreakFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewPomodoroBreak should disable id FormControl', () => {
        const formGroup = service.createPomodoroBreakFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
