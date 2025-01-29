import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import { IHabitTrack, NewHabitTrack } from '../habit-track.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IHabitTrack for edit and NewHabitTrackFormGroupInput for create.
 */
type HabitTrackFormGroupInput = IHabitTrack | PartialWithRequiredKeyOf<NewHabitTrack>;

type HabitTrackFormDefaults = Pick<NewHabitTrack, 'id'>;

type HabitTrackFormGroupContent = {
  id: FormControl<IHabitTrack['id'] | NewHabitTrack['id']>;
  habitId: FormControl<IHabitTrack['habitId']>;
  habitName: FormControl<IHabitTrack['habitName']>;
  description: FormControl<IHabitTrack['description']>;
  category: FormControl<IHabitTrack['category']>;
  startDate: FormControl<IHabitTrack['startDate']>;
  endDate: FormControl<IHabitTrack['endDate']>;
};

export type HabitTrackFormGroup = FormGroup<HabitTrackFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class HabitTrackFormService {
  createHabitTrackFormGroup(habitTrack: HabitTrackFormGroupInput = { id: null }): HabitTrackFormGroup {
    const habitTrackRawValue = {
      ...this.getFormDefaults(),
      ...habitTrack,
    };
    return new FormGroup<HabitTrackFormGroupContent>({
      id: new FormControl(
        { value: habitTrackRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      habitId: new FormControl(habitTrackRawValue.habitId),
      habitName: new FormControl(habitTrackRawValue.habitName),
      description: new FormControl(habitTrackRawValue.description),
      category: new FormControl(habitTrackRawValue.category),
      startDate: new FormControl(habitTrackRawValue.startDate),
      endDate: new FormControl(habitTrackRawValue.endDate),
    });
  }

  getHabitTrack(form: HabitTrackFormGroup): IHabitTrack | NewHabitTrack {
    return form.getRawValue() as IHabitTrack | NewHabitTrack;
  }

  resetForm(form: HabitTrackFormGroup, habitTrack: HabitTrackFormGroupInput): void {
    const habitTrackRawValue = { ...this.getFormDefaults(), ...habitTrack };
    form.reset(
      {
        ...habitTrackRawValue,
        id: { value: habitTrackRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): HabitTrackFormDefaults {
    return {
      id: null,
    };
  }
}
