import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import { ITongueTwister, NewTongueTwister } from '../tongue-twister.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts ITongueTwister for edit and NewTongueTwisterFormGroupInput for create.
 */
type TongueTwisterFormGroupInput = ITongueTwister | PartialWithRequiredKeyOf<NewTongueTwister>;

type TongueTwisterFormDefaults = Pick<NewTongueTwister, 'id'>;

type TongueTwisterFormGroupContent = {
  id: FormControl<ITongueTwister['id'] | NewTongueTwister['id']>;
  text: FormControl<ITongueTwister['text']>;
  language: FormControl<ITongueTwister['language']>;
  difficultyLevel: FormControl<ITongueTwister['difficultyLevel']>;
  creator: FormControl<ITongueTwister['creator']>;
};

export type TongueTwisterFormGroup = FormGroup<TongueTwisterFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class TongueTwisterFormService {
  createTongueTwisterFormGroup(tongueTwister: TongueTwisterFormGroupInput = { id: null }): TongueTwisterFormGroup {
    const tongueTwisterRawValue = {
      ...this.getFormDefaults(),
      ...tongueTwister,
    };
    return new FormGroup<TongueTwisterFormGroupContent>({
      id: new FormControl(
        { value: tongueTwisterRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      text: new FormControl(tongueTwisterRawValue.text, {
        validators: [Validators.required],
      }),
      language: new FormControl(tongueTwisterRawValue.language, {
        validators: [Validators.required],
      }),
      difficultyLevel: new FormControl(tongueTwisterRawValue.difficultyLevel),
      creator: new FormControl(tongueTwisterRawValue.creator),
    });
  }

  getTongueTwister(form: TongueTwisterFormGroup): ITongueTwister | NewTongueTwister {
    return form.getRawValue() as ITongueTwister | NewTongueTwister;
  }

  resetForm(form: TongueTwisterFormGroup, tongueTwister: TongueTwisterFormGroupInput): void {
    const tongueTwisterRawValue = { ...this.getFormDefaults(), ...tongueTwister };
    form.reset(
      {
        ...tongueTwisterRawValue,
        id: { value: tongueTwisterRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): TongueTwisterFormDefaults {
    return {
      id: null,
    };
  }
}
