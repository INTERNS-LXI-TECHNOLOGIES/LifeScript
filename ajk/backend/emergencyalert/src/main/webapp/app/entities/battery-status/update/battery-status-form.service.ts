import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import { IBatteryStatus, NewBatteryStatus } from '../battery-status.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IBatteryStatus for edit and NewBatteryStatusFormGroupInput for create.
 */
type BatteryStatusFormGroupInput = IBatteryStatus | PartialWithRequiredKeyOf<NewBatteryStatus>;

type BatteryStatusFormDefaults = Pick<NewBatteryStatus, 'id'>;

type BatteryStatusFormGroupContent = {
  id: FormControl<IBatteryStatus['id'] | NewBatteryStatus['id']>;
  batteryLevel: FormControl<IBatteryStatus['batteryLevel']>;
};

export type BatteryStatusFormGroup = FormGroup<BatteryStatusFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class BatteryStatusFormService {
  createBatteryStatusFormGroup(batteryStatus: BatteryStatusFormGroupInput = { id: null }): BatteryStatusFormGroup {
    const batteryStatusRawValue = {
      ...this.getFormDefaults(),
      ...batteryStatus,
    };
    return new FormGroup<BatteryStatusFormGroupContent>({
      id: new FormControl(
        { value: batteryStatusRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      batteryLevel: new FormControl(batteryStatusRawValue.batteryLevel, {
        validators: [Validators.required],
      }),
    });
  }

  getBatteryStatus(form: BatteryStatusFormGroup): IBatteryStatus | NewBatteryStatus {
    return form.getRawValue() as IBatteryStatus | NewBatteryStatus;
  }

  resetForm(form: BatteryStatusFormGroup, batteryStatus: BatteryStatusFormGroupInput): void {
    const batteryStatusRawValue = { ...this.getFormDefaults(), ...batteryStatus };
    form.reset(
      {
        ...batteryStatusRawValue,
        id: { value: batteryStatusRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): BatteryStatusFormDefaults {
    return {
      id: null,
    };
  }
}
