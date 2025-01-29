import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import { IUserEntity, NewUserEntity } from '../user-entity.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IUserEntity for edit and NewUserEntityFormGroupInput for create.
 */
type UserEntityFormGroupInput = IUserEntity | PartialWithRequiredKeyOf<NewUserEntity>;

type UserEntityFormDefaults = Pick<NewUserEntity, 'id'>;

type UserEntityFormGroupContent = {
  id: FormControl<IUserEntity['id'] | NewUserEntity['id']>;
  userId: FormControl<IUserEntity['userId']>;
  userName: FormControl<IUserEntity['userName']>;
};

export type UserEntityFormGroup = FormGroup<UserEntityFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class UserEntityFormService {
  createUserEntityFormGroup(userEntity: UserEntityFormGroupInput = { id: null }): UserEntityFormGroup {
    const userEntityRawValue = {
      ...this.getFormDefaults(),
      ...userEntity,
    };
    return new FormGroup<UserEntityFormGroupContent>({
      id: new FormControl(
        { value: userEntityRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      userId: new FormControl(userEntityRawValue.userId),
      userName: new FormControl(userEntityRawValue.userName),
    });
  }

  getUserEntity(form: UserEntityFormGroup): IUserEntity | NewUserEntity {
    return form.getRawValue() as IUserEntity | NewUserEntity;
  }

  resetForm(form: UserEntityFormGroup, userEntity: UserEntityFormGroupInput): void {
    const userEntityRawValue = { ...this.getFormDefaults(), ...userEntity };
    form.reset(
      {
        ...userEntityRawValue,
        id: { value: userEntityRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): UserEntityFormDefaults {
    return {
      id: null,
    };
  }
}
