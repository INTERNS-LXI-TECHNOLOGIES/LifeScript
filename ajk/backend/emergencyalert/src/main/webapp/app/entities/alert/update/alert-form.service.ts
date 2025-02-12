import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import dayjs from 'dayjs/esm';
import { DATE_TIME_FORMAT } from 'app/config/input.constants';
import { IAlert, NewAlert } from '../alert.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IAlert for edit and NewAlertFormGroupInput for create.
 */
type AlertFormGroupInput = IAlert | PartialWithRequiredKeyOf<NewAlert>;

/**
 * Type that converts some properties for forms.
 */
type FormValueOf<T extends IAlert | NewAlert> = Omit<T, 'timestamp'> & {
  timestamp?: string | null;
};

type AlertFormRawValue = FormValueOf<IAlert>;

type NewAlertFormRawValue = FormValueOf<NewAlert>;

type AlertFormDefaults = Pick<NewAlert, 'id' | 'timestamp'>;

type AlertFormGroupContent = {
  id: FormControl<AlertFormRawValue['id'] | NewAlert['id']>;
  latitude: FormControl<AlertFormRawValue['latitude']>;
  longitude: FormControl<AlertFormRawValue['longitude']>;
  timestamp: FormControl<AlertFormRawValue['timestamp']>;
  deviceId: FormControl<AlertFormRawValue['deviceId']>;
  status: FormControl<AlertFormRawValue['status']>;
  child: FormControl<AlertFormRawValue['child']>;
};

export type AlertFormGroup = FormGroup<AlertFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class AlertFormService {
  createAlertFormGroup(alert: AlertFormGroupInput = { id: null }): AlertFormGroup {
    const alertRawValue = this.convertAlertToAlertRawValue({
      ...this.getFormDefaults(),
      ...alert,
    });
    return new FormGroup<AlertFormGroupContent>({
      id: new FormControl(
        { value: alertRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      latitude: new FormControl(alertRawValue.latitude, {
        validators: [Validators.required],
      }),
      longitude: new FormControl(alertRawValue.longitude, {
        validators: [Validators.required],
      }),
      timestamp: new FormControl(alertRawValue.timestamp, {
        validators: [Validators.required],
      }),
      deviceId: new FormControl(alertRawValue.deviceId, {
        validators: [Validators.required],
      }),
      status: new FormControl(alertRawValue.status, {
        validators: [Validators.required],
      }),
      child: new FormControl(alertRawValue.child),
    });
  }

  getAlert(form: AlertFormGroup): IAlert | NewAlert {
    return this.convertAlertRawValueToAlert(form.getRawValue() as AlertFormRawValue | NewAlertFormRawValue);
  }

  resetForm(form: AlertFormGroup, alert: AlertFormGroupInput): void {
    const alertRawValue = this.convertAlertToAlertRawValue({ ...this.getFormDefaults(), ...alert });
    form.reset(
      {
        ...alertRawValue,
        id: { value: alertRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): AlertFormDefaults {
    const currentTime = dayjs();

    return {
      id: null,
      timestamp: currentTime,
    };
  }

  private convertAlertRawValueToAlert(rawAlert: AlertFormRawValue | NewAlertFormRawValue): IAlert | NewAlert {
    return {
      ...rawAlert,
      timestamp: dayjs(rawAlert.timestamp, DATE_TIME_FORMAT),
    };
  }

  private convertAlertToAlertRawValue(
    alert: IAlert | (Partial<NewAlert> & AlertFormDefaults),
  ): AlertFormRawValue | PartialWithRequiredKeyOf<NewAlertFormRawValue> {
    return {
      ...alert,
      timestamp: alert.timestamp ? alert.timestamp.format(DATE_TIME_FORMAT) : undefined,
    };
  }
}
