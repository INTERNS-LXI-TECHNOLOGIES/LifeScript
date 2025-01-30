import { Component, OnInit, inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IUserEntity } from '../user-entity.model';
import { UserEntityService } from '../service/user-entity.service';
import { UserEntityFormGroup, UserEntityFormService } from './user-entity-form.service';

@Component({
  selector: 'jhi-user-entity-update',
  templateUrl: './user-entity-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class UserEntityUpdateComponent implements OnInit {
  isSaving = false;
  userEntity: IUserEntity | null = null;

  protected userEntityService = inject(UserEntityService);
  protected userEntityFormService = inject(UserEntityFormService);
  protected activatedRoute = inject(ActivatedRoute);

  // eslint-disable-next-line @typescript-eslint/member-ordering
  editForm: UserEntityFormGroup = this.userEntityFormService.createUserEntityFormGroup();

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ userEntity }) => {
      this.userEntity = userEntity;
      if (userEntity) {
        this.updateForm(userEntity);
      }
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const userEntity = this.userEntityFormService.getUserEntity(this.editForm);
    if (userEntity.id !== null) {
      this.subscribeToSaveResponse(this.userEntityService.update(userEntity));
    } else {
      this.subscribeToSaveResponse(this.userEntityService.create(userEntity));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IUserEntity>>): void {
    result.pipe(finalize(() => this.onSaveFinalize())).subscribe({
      next: () => this.onSaveSuccess(),
      error: () => this.onSaveError(),
    });
  }

  protected onSaveSuccess(): void {
    this.previousState();
  }

  protected onSaveError(): void {
    // Api for inheritance.
  }

  protected onSaveFinalize(): void {
    this.isSaving = false;
  }

  protected updateForm(userEntity: IUserEntity): void {
    this.userEntity = userEntity;
    this.userEntityFormService.resetForm(this.editForm, userEntity);
  }
}
