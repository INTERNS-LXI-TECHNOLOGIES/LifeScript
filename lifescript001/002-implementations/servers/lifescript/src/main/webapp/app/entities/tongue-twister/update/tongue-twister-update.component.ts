import { Component, inject, OnInit } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize, map } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IUser } from 'app/entities/user/user.model';
import { UserService } from 'app/entities/user/service/user.service';
import { ITongueTwister } from '../tongue-twister.model';
import { TongueTwisterService } from '../service/tongue-twister.service';
import { TongueTwisterFormService, TongueTwisterFormGroup } from './tongue-twister-form.service';

@Component({
  standalone: true,
  selector: 'jhi-tongue-twister-update',
  templateUrl: './tongue-twister-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class TongueTwisterUpdateComponent implements OnInit {
  isSaving = false;
  tongueTwister: ITongueTwister | null = null;

  usersSharedCollection: IUser[] = [];

  protected tongueTwisterService = inject(TongueTwisterService);
  protected tongueTwisterFormService = inject(TongueTwisterFormService);
  protected userService = inject(UserService);
  protected activatedRoute = inject(ActivatedRoute);

  // eslint-disable-next-line @typescript-eslint/member-ordering
  editForm: TongueTwisterFormGroup = this.tongueTwisterFormService.createTongueTwisterFormGroup();

  compareUser = (o1: IUser | null, o2: IUser | null): boolean => this.userService.compareUser(o1, o2);

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ tongueTwister }) => {
      this.tongueTwister = tongueTwister;
      if (tongueTwister) {
        this.updateForm(tongueTwister);
      }

      this.loadRelationshipsOptions();
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const tongueTwister = this.tongueTwisterFormService.getTongueTwister(this.editForm);
    if (tongueTwister.id !== null) {
      this.subscribeToSaveResponse(this.tongueTwisterService.update(tongueTwister));
    } else {
      this.subscribeToSaveResponse(this.tongueTwisterService.create(tongueTwister));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<ITongueTwister>>): void {
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

  protected updateForm(tongueTwister: ITongueTwister): void {
    this.tongueTwister = tongueTwister;
    this.tongueTwisterFormService.resetForm(this.editForm, tongueTwister);

    this.usersSharedCollection = this.userService.addUserToCollectionIfMissing<IUser>(this.usersSharedCollection, tongueTwister.creator);
  }

  protected loadRelationshipsOptions(): void {
    this.userService
      .query()
      .pipe(map((res: HttpResponse<IUser[]>) => res.body ?? []))
      .pipe(map((users: IUser[]) => this.userService.addUserToCollectionIfMissing<IUser>(users, this.tongueTwister?.creator)))
      .subscribe((users: IUser[]) => (this.usersSharedCollection = users));
  }
}
