import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import { IEmergencyContact, NewEmergencyContact } from '../emergency-contact.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IEmergencyContact for edit and NewEmergencyContactFormGroupInput for create.
 */
type EmergencyContactFormGroupInput = IEmergencyContact | PartialWithRequiredKeyOf<NewEmergencyContact>;

type EmergencyContactFormDefaults = Pick<NewEmergencyContact, 'id'>;

type EmergencyContactFormGroupContent = {
  id: FormControl<IEmergencyContact['id'] | NewEmergencyContact['id']>;
  name: FormControl<IEmergencyContact['name']>;
  type: FormControl<IEmergencyContact['type']>;
  phoneNumber: FormControl<IEmergencyContact['phoneNumber']>;
  parent: FormControl<IEmergencyContact['parent']>;
};

export type EmergencyContactFormGroup = FormGroup<EmergencyContactFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class EmergencyContactFormService {
  createEmergencyContactFormGroup(emergencyContact: EmergencyContactFormGroupInput = { id: null }): EmergencyContactFormGroup {
    const emergencyContactRawValue = {
      ...this.getFormDefaults(),
      ...emergencyContact,
    };
    return new FormGroup<EmergencyContactFormGroupContent>({
      id: new FormControl(
        { value: emergencyContactRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      name: new FormControl(emergencyContactRawValue.name, {
        validators: [Validators.required],
      }),
      type: new FormControl(emergencyContactRawValue.type, {
        validators: [Validators.required],
      }),
      phoneNumber: new FormControl(emergencyContactRawValue.phoneNumber, {
        validators: [Validators.required],
      }),
      parent: new FormControl(emergencyContactRawValue.parent),
    });
  }

  getEmergencyContact(form: EmergencyContactFormGroup): IEmergencyContact | NewEmergencyContact {
    return form.getRawValue() as IEmergencyContact | NewEmergencyContact;
  }

  resetForm(form: EmergencyContactFormGroup, emergencyContact: EmergencyContactFormGroupInput): void {
    const emergencyContactRawValue = { ...this.getFormDefaults(), ...emergencyContact };
    form.reset(
      {
        ...emergencyContactRawValue,
        id: { value: emergencyContactRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): EmergencyContactFormDefaults {
    return {
      id: null,
    };
  }
}
