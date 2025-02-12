import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import { IParent, NewParent } from '../parent.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IParent for edit and NewParentFormGroupInput for create.
 */
type ParentFormGroupInput = IParent | PartialWithRequiredKeyOf<NewParent>;

type ParentFormDefaults = Pick<NewParent, 'id'>;

type ParentFormGroupContent = {
  id: FormControl<IParent['id'] | NewParent['id']>;
  name: FormControl<IParent['name']>;
  phoneNumber: FormControl<IParent['phoneNumber']>;
};

export type ParentFormGroup = FormGroup<ParentFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class ParentFormService {
  createParentFormGroup(parent: ParentFormGroupInput = { id: null }): ParentFormGroup {
    const parentRawValue = {
      ...this.getFormDefaults(),
      ...parent,
    };
    return new FormGroup<ParentFormGroupContent>({
      id: new FormControl(
        { value: parentRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      name: new FormControl(parentRawValue.name, {
        validators: [Validators.required],
      }),
      phoneNumber: new FormControl(parentRawValue.phoneNumber, {
        validators: [Validators.required],
      }),
    });
  }

  getParent(form: ParentFormGroup): IParent | NewParent {
    return form.getRawValue() as IParent | NewParent;
  }

  resetForm(form: ParentFormGroup, parent: ParentFormGroupInput): void {
    const parentRawValue = { ...this.getFormDefaults(), ...parent };
    form.reset(
      {
        ...parentRawValue,
        id: { value: parentRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): ParentFormDefaults {
    return {
      id: null,
    };
  }
}
