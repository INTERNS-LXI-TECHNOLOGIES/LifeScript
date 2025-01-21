import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import { IHabitTracker, NewHabitTracker } from '../habit-tracker.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IHabitTracker for edit and NewHabitTrackerFormGroupInput for create.
 */
type HabitTrackerFormGroupInput = IHabitTracker | PartialWithRequiredKeyOf<NewHabitTracker>;

type HabitTrackerFormDefaults = Pick<NewHabitTracker, 'id'>;

type HabitTrackerFormGroupContent = {
  id: FormControl<IHabitTracker['id'] | NewHabitTracker['id']>;
  habitId: FormControl<IHabitTracker['habitId']>;
  habitName: FormControl<IHabitTracker['habitName']>;
  description: FormControl<IHabitTracker['description']>;
  startDate: FormControl<IHabitTracker['startDate']>;
  endDate: FormControl<IHabitTracker['endDate']>;
};

export type HabitTrackerFormGroup = FormGroup<HabitTrackerFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class HabitTrackerFormService {
  createHabitTrackerFormGroup(habitTracker: HabitTrackerFormGroupInput = { id: null }): HabitTrackerFormGroup {
    const habitTrackerRawValue = {
      ...this.getFormDefaults(),
      ...habitTracker,
    };
    return new FormGroup<HabitTrackerFormGroupContent>({
      id: new FormControl(
        { value: habitTrackerRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      habitId: new FormControl(habitTrackerRawValue.habitId),
      habitName: new FormControl(habitTrackerRawValue.habitName),
      description: new FormControl(habitTrackerRawValue.description),
      startDate: new FormControl(habitTrackerRawValue.startDate),
      endDate: new FormControl(habitTrackerRawValue.endDate),
    });
  }

  getHabitTracker(form: HabitTrackerFormGroup): IHabitTracker | NewHabitTracker {
    return form.getRawValue() as IHabitTracker | NewHabitTracker;
  }

  resetForm(form: HabitTrackerFormGroup, habitTracker: HabitTrackerFormGroupInput): void {
    const habitTrackerRawValue = { ...this.getFormDefaults(), ...habitTracker };
    form.reset(
      {
        ...habitTrackerRawValue,
        id: { value: habitTrackerRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): HabitTrackerFormDefaults {
    return {
      id: null,
    };
  }
}
