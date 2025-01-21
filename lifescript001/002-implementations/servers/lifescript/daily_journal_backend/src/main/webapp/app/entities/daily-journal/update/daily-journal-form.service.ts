import { Injectable } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

import { IDailyJournal, NewDailyJournal } from '../daily-journal.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IDailyJournal for edit and NewDailyJournalFormGroupInput for create.
 */
type DailyJournalFormGroupInput = IDailyJournal | PartialWithRequiredKeyOf<NewDailyJournal>;

type DailyJournalFormDefaults = Pick<NewDailyJournal, 'id'>;

type DailyJournalFormGroupContent = {
  id: FormControl<IDailyJournal['id'] | NewDailyJournal['id']>;
  title: FormControl<IDailyJournal['title']>;
  content: FormControl<IDailyJournal['content']>;
  date: FormControl<IDailyJournal['date']>;
};

export type DailyJournalFormGroup = FormGroup<DailyJournalFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class DailyJournalFormService {
  createDailyJournalFormGroup(dailyJournal: DailyJournalFormGroupInput = { id: null }): DailyJournalFormGroup {
    const dailyJournalRawValue = {
      ...this.getFormDefaults(),
      ...dailyJournal,
    };
    return new FormGroup<DailyJournalFormGroupContent>({
      id: new FormControl(
        { value: dailyJournalRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      title: new FormControl(dailyJournalRawValue.title, {
        validators: [Validators.required],
      }),
      content: new FormControl(dailyJournalRawValue.content, {
        validators: [Validators.required],
      }),
      date: new FormControl(dailyJournalRawValue.date, {
        validators: [Validators.required],
      }),
    });
  }

  getDailyJournal(form: DailyJournalFormGroup): IDailyJournal | NewDailyJournal {
    return form.getRawValue() as IDailyJournal | NewDailyJournal;
  }

  resetForm(form: DailyJournalFormGroup, dailyJournal: DailyJournalFormGroupInput): void {
    const dailyJournalRawValue = { ...this.getFormDefaults(), ...dailyJournal };
    form.reset(
      {
        ...dailyJournalRawValue,
        id: { value: dailyJournalRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): DailyJournalFormDefaults {
    return {
      id: null,
    };
  }
}
