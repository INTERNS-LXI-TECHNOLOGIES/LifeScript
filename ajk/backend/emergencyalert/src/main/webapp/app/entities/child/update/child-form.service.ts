import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import { IChild, NewChild } from '../child.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IChild for edit and NewChildFormGroupInput for create.
 */
type ChildFormGroupInput = IChild | PartialWithRequiredKeyOf<NewChild>;

type ChildFormDefaults = Pick<NewChild, 'id'>;

type ChildFormGroupContent = {
  id: FormControl<IChild['id'] | NewChild['id']>;
  name: FormControl<IChild['name']>;
  age: FormControl<IChild['age']>;
  emergencyContact: FormControl<IChild['emergencyContact']>;
  geoFence: FormControl<IChild['geoFence']>;
  batteryStatus: FormControl<IChild['batteryStatus']>;
  teacher: FormControl<IChild['teacher']>;
  parent: FormControl<IChild['parent']>;
};

export type ChildFormGroup = FormGroup<ChildFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class ChildFormService {
  createChildFormGroup(child: ChildFormGroupInput = { id: null }): ChildFormGroup {
    const childRawValue = {
      ...this.getFormDefaults(),
      ...child,
    };
    return new FormGroup<ChildFormGroupContent>({
      id: new FormControl(
        { value: childRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      name: new FormControl(childRawValue.name, {
        validators: [Validators.required],
      }),
      age: new FormControl(childRawValue.age, {
        validators: [Validators.required],
      }),
      emergencyContact: new FormControl(childRawValue.emergencyContact),
      geoFence: new FormControl(childRawValue.geoFence),
      batteryStatus: new FormControl(childRawValue.batteryStatus),
      teacher: new FormControl(childRawValue.teacher),
      parent: new FormControl(childRawValue.parent),
    });
  }

  getChild(form: ChildFormGroup): IChild | NewChild {
    return form.getRawValue() as IChild | NewChild;
  }

  resetForm(form: ChildFormGroup, child: ChildFormGroupInput): void {
    const childRawValue = { ...this.getFormDefaults(), ...child };
    form.reset(
      {
        ...childRawValue,
        id: { value: childRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): ChildFormDefaults {
    return {
      id: null,
    };
  }
}
