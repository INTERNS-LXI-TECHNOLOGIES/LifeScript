import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import dayjs from 'dayjs/esm';
import { DATE_TIME_FORMAT } from 'app/config/input.constants';
import { IGpsEntry, NewGpsEntry } from '../gps-entry.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IGpsEntry for edit and NewGpsEntryFormGroupInput for create.
 */
type GpsEntryFormGroupInput = IGpsEntry | PartialWithRequiredKeyOf<NewGpsEntry>;

/**
 * Type that converts some properties for forms.
 */
type FormValueOf<T extends IGpsEntry | NewGpsEntry> = Omit<T, 'timestamp'> & {
  timestamp?: string | null;
};

type GpsEntryFormRawValue = FormValueOf<IGpsEntry>;

type NewGpsEntryFormRawValue = FormValueOf<NewGpsEntry>;

type GpsEntryFormDefaults = Pick<NewGpsEntry, 'id' | 'timestamp'>;

type GpsEntryFormGroupContent = {
  id: FormControl<GpsEntryFormRawValue['id'] | NewGpsEntry['id']>;
  latitude: FormControl<GpsEntryFormRawValue['latitude']>;
  longitude: FormControl<GpsEntryFormRawValue['longitude']>;
  timestamp: FormControl<GpsEntryFormRawValue['timestamp']>;
  deviceId: FormControl<GpsEntryFormRawValue['deviceId']>;
  status: FormControl<GpsEntryFormRawValue['status']>;
  child: FormControl<GpsEntryFormRawValue['child']>;
};

export type GpsEntryFormGroup = FormGroup<GpsEntryFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class GpsEntryFormService {
  createGpsEntryFormGroup(gpsEntry: GpsEntryFormGroupInput = { id: null }): GpsEntryFormGroup {
    const gpsEntryRawValue = this.convertGpsEntryToGpsEntryRawValue({
      ...this.getFormDefaults(),
      ...gpsEntry,
    });
    return new FormGroup<GpsEntryFormGroupContent>({
      id: new FormControl(
        { value: gpsEntryRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      latitude: new FormControl(gpsEntryRawValue.latitude, {
        validators: [Validators.required],
      }),
      longitude: new FormControl(gpsEntryRawValue.longitude, {
        validators: [Validators.required],
      }),
      timestamp: new FormControl(gpsEntryRawValue.timestamp, {
        validators: [Validators.required],
      }),
      deviceId: new FormControl(gpsEntryRawValue.deviceId, {
        validators: [Validators.required],
      }),
      status: new FormControl(gpsEntryRawValue.status, {
        validators: [Validators.required],
      }),
      child: new FormControl(gpsEntryRawValue.child),
    });
  }

  getGpsEntry(form: GpsEntryFormGroup): IGpsEntry | NewGpsEntry {
    return this.convertGpsEntryRawValueToGpsEntry(form.getRawValue() as GpsEntryFormRawValue | NewGpsEntryFormRawValue);
  }

  resetForm(form: GpsEntryFormGroup, gpsEntry: GpsEntryFormGroupInput): void {
    const gpsEntryRawValue = this.convertGpsEntryToGpsEntryRawValue({ ...this.getFormDefaults(), ...gpsEntry });
    form.reset(
      {
        ...gpsEntryRawValue,
        id: { value: gpsEntryRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): GpsEntryFormDefaults {
    const currentTime = dayjs();

    return {
      id: null,
      timestamp: currentTime,
    };
  }

  private convertGpsEntryRawValueToGpsEntry(rawGpsEntry: GpsEntryFormRawValue | NewGpsEntryFormRawValue): IGpsEntry | NewGpsEntry {
    return {
      ...rawGpsEntry,
      timestamp: dayjs(rawGpsEntry.timestamp, DATE_TIME_FORMAT),
    };
  }

  private convertGpsEntryToGpsEntryRawValue(
    gpsEntry: IGpsEntry | (Partial<NewGpsEntry> & GpsEntryFormDefaults),
  ): GpsEntryFormRawValue | PartialWithRequiredKeyOf<NewGpsEntryFormRawValue> {
    return {
      ...gpsEntry,
      timestamp: gpsEntry.timestamp ? gpsEntry.timestamp.format(DATE_TIME_FORMAT) : undefined,
    };
  }
}
