import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import { ITwisterPractice, NewTwisterPractice } from '../twister-practice.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts ITwisterPractice for edit and NewTwisterPracticeFormGroupInput for create.
 */
type TwisterPracticeFormGroupInput = ITwisterPractice | PartialWithRequiredKeyOf<NewTwisterPractice>;

type TwisterPracticeFormDefaults = Pick<NewTwisterPractice, 'id'>;

type TwisterPracticeFormGroupContent = {
  id: FormControl<ITwisterPractice['id'] | NewTwisterPractice['id']>;
  score: FormControl<ITwisterPractice['score']>;
  timesPracticed: FormControl<ITwisterPractice['timesPracticed']>;
  corrections: FormControl<ITwisterPractice['corrections']>;
  mediaContent: FormControl<ITwisterPractice['mediaContent']>;
};

export type TwisterPracticeFormGroup = FormGroup<TwisterPracticeFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class TwisterPracticeFormService {
  createTwisterPracticeFormGroup(twisterPractice: TwisterPracticeFormGroupInput = { id: null }): TwisterPracticeFormGroup {
    const twisterPracticeRawValue = {
      ...this.getFormDefaults(),
      ...twisterPractice,
    };
    return new FormGroup<TwisterPracticeFormGroupContent>({
      id: new FormControl(
        { value: twisterPracticeRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      score: new FormControl(twisterPracticeRawValue.score),
      timesPracticed: new FormControl(twisterPracticeRawValue.timesPracticed),
      corrections: new FormControl(twisterPracticeRawValue.corrections),
      mediaContent: new FormControl(twisterPracticeRawValue.mediaContent),
    });
  }

  getTwisterPractice(form: TwisterPracticeFormGroup): ITwisterPractice | NewTwisterPractice {
    return form.getRawValue() as ITwisterPractice | NewTwisterPractice;
  }

  resetForm(form: TwisterPracticeFormGroup, twisterPractice: TwisterPracticeFormGroupInput): void {
    const twisterPracticeRawValue = { ...this.getFormDefaults(), ...twisterPractice };
    form.reset(
      {
        ...twisterPracticeRawValue,
        id: { value: twisterPracticeRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): TwisterPracticeFormDefaults {
    return {
      id: null,
    };
  }
}
