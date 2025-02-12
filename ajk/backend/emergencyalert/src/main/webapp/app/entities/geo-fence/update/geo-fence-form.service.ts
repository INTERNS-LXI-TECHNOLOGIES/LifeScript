import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import { IGeoFence, NewGeoFence } from '../geo-fence.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IGeoFence for edit and NewGeoFenceFormGroupInput for create.
 */
type GeoFenceFormGroupInput = IGeoFence | PartialWithRequiredKeyOf<NewGeoFence>;

type GeoFenceFormDefaults = Pick<NewGeoFence, 'id'>;

type GeoFenceFormGroupContent = {
  id: FormControl<IGeoFence['id'] | NewGeoFence['id']>;
  safeZones: FormControl<IGeoFence['safeZones']>;
};

export type GeoFenceFormGroup = FormGroup<GeoFenceFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class GeoFenceFormService {
  createGeoFenceFormGroup(geoFence: GeoFenceFormGroupInput = { id: null }): GeoFenceFormGroup {
    const geoFenceRawValue = {
      ...this.getFormDefaults(),
      ...geoFence,
    };
    return new FormGroup<GeoFenceFormGroupContent>({
      id: new FormControl(
        { value: geoFenceRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      safeZones: new FormControl(geoFenceRawValue.safeZones, {
        validators: [Validators.required],
      }),
    });
  }

  getGeoFence(form: GeoFenceFormGroup): IGeoFence | NewGeoFence {
    return form.getRawValue() as IGeoFence | NewGeoFence;
  }

  resetForm(form: GeoFenceFormGroup, geoFence: GeoFenceFormGroupInput): void {
    const geoFenceRawValue = { ...this.getFormDefaults(), ...geoFence };
    form.reset(
      {
        ...geoFenceRawValue,
        id: { value: geoFenceRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): GeoFenceFormDefaults {
    return {
      id: null,
    };
  }
}
