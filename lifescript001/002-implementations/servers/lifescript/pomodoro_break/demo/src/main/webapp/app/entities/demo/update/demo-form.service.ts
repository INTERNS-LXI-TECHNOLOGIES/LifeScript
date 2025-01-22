import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import { IDemo, NewDemo } from '../demo.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IDemo for edit and NewDemoFormGroupInput for create.
 */
type DemoFormGroupInput = IDemo | PartialWithRequiredKeyOf<NewDemo>;

type DemoFormDefaults = Pick<NewDemo, 'id'>;

type DemoFormGroupContent = {
  id: FormControl<IDemo['id'] | NewDemo['id']>;
  username: FormControl<IDemo['username']>;
  mobileNumber: FormControl<IDemo['mobileNumber']>;
};

export type DemoFormGroup = FormGroup<DemoFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class DemoFormService {
  createDemoFormGroup(demo: DemoFormGroupInput = { id: null }): DemoFormGroup {
    const demoRawValue = {
      ...this.getFormDefaults(),
      ...demo,
    };
    return new FormGroup<DemoFormGroupContent>({
      id: new FormControl(
        { value: demoRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      username: new FormControl(demoRawValue.username),
      mobileNumber: new FormControl(demoRawValue.mobileNumber),
    });
  }

  getDemo(form: DemoFormGroup): IDemo | NewDemo {
    return form.getRawValue() as IDemo | NewDemo;
  }

  resetForm(form: DemoFormGroup, demo: DemoFormGroupInput): void {
    const demoRawValue = { ...this.getFormDefaults(), ...demo };
    form.reset(
      {
        ...demoRawValue,
        id: { value: demoRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): DemoFormDefaults {
    return {
      id: null,
    };
  }
}
