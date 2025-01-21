import { TestBed } from '@angular/core/testing';

import { sampleWithRequiredData, sampleWithNewData } from '../daily-journal.test-samples';

import { DailyJournalFormService } from './daily-journal-form.service';

describe('DailyJournal Form Service', () => {
  let service: DailyJournalFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(DailyJournalFormService);
  });

  describe('Service methods', () => {
    describe('createDailyJournalFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createDailyJournalFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            title: expect.any(Object),
            content: expect.any(Object),
            date: expect.any(Object),
          }),
        );
      });

      it('passing IDailyJournal should create a new form with FormGroup', () => {
        const formGroup = service.createDailyJournalFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            title: expect.any(Object),
            content: expect.any(Object),
            date: expect.any(Object),
          }),
        );
      });
    });

    describe('getDailyJournal', () => {
      it('should return NewDailyJournal for default DailyJournal initial value', () => {
        const formGroup = service.createDailyJournalFormGroup(sampleWithNewData);

        const dailyJournal = service.getDailyJournal(formGroup) as any;

        expect(dailyJournal).toMatchObject(sampleWithNewData);
      });

      it('should return NewDailyJournal for empty DailyJournal initial value', () => {
        const formGroup = service.createDailyJournalFormGroup();

        const dailyJournal = service.getDailyJournal(formGroup) as any;

        expect(dailyJournal).toMatchObject({});
      });

      it('should return IDailyJournal', () => {
        const formGroup = service.createDailyJournalFormGroup(sampleWithRequiredData);

        const dailyJournal = service.getDailyJournal(formGroup) as any;

        expect(dailyJournal).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IDailyJournal should not enable id FormControl', () => {
        const formGroup = service.createDailyJournalFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewDailyJournal should disable id FormControl', () => {
        const formGroup = service.createDailyJournalFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
