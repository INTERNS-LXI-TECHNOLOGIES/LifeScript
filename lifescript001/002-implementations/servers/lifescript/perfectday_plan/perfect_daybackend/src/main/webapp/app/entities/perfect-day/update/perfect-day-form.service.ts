import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import { IPerfectDay, NewPerfectDay } from '../perfect-day.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IPerfectDay for edit and NewPerfectDayFormGroupInput for create.
 */
type PerfectDayFormGroupInput = IPerfectDay | PartialWithRequiredKeyOf<NewPerfectDay>;

type PerfectDayFormDefaults = Pick<NewPerfectDay, 'id'>;

type PerfectDayFormGroupContent = {
  id: FormControl<IPerfectDay['id'] | NewPerfectDay['id']>;
  title: FormControl<IPerfectDay['title']>;
  description: FormControl<IPerfectDay['description']>;
  date: FormControl<IPerfectDay['date']>;
};

export type PerfectDayFormGroup = FormGroup<PerfectDayFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class PerfectDayFormService {
  createPerfectDayFormGroup(perfectDay: PerfectDayFormGroupInput = { id: null }): PerfectDayFormGroup {
    const perfectDayRawValue = {
      ...this.getFormDefaults(),
      ...perfectDay,
    };
    return new FormGroup<PerfectDayFormGroupContent>({
      id: new FormControl(
        { value: perfectDayRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      title: new FormControl(perfectDayRawValue.title, {
        validators: [Validators.required],
      }),
      description: new FormControl(perfectDayRawValue.description),
      date: new FormControl(perfectDayRawValue.date, {
        validators: [Validators.required],
      }),
    });
  }

  getPerfectDay(form: PerfectDayFormGroup): IPerfectDay | NewPerfectDay {
    return form.getRawValue() as IPerfectDay | NewPerfectDay;
  }

  resetForm(form: PerfectDayFormGroup, perfectDay: PerfectDayFormGroupInput): void {
    const perfectDayRawValue = { ...this.getFormDefaults(), ...perfectDay };
    form.reset(
      {
        ...perfectDayRawValue,
        id: { value: perfectDayRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): PerfectDayFormDefaults {
    return {
      id: null,
    };
  }
}
