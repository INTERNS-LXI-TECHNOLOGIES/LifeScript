import { Component, OnInit, inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IHabitTrack } from '../habit-track.model';
import { HabitTrackService } from '../service/habit-track.service';
import { HabitTrackFormGroup, HabitTrackFormService } from './habit-track-form.service';

@Component({
  selector: 'jhi-habit-track-update',
  templateUrl: './habit-track-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class HabitTrackUpdateComponent implements OnInit {
  isSaving = false;
  habitTrack: IHabitTrack | null = null;

  protected habitTrackService = inject(HabitTrackService);
  protected habitTrackFormService = inject(HabitTrackFormService);
  protected activatedRoute = inject(ActivatedRoute);

  // eslint-disable-next-line @typescript-eslint/member-ordering
  editForm: HabitTrackFormGroup = this.habitTrackFormService.createHabitTrackFormGroup();

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ habitTrack }) => {
      this.habitTrack = habitTrack;
      if (habitTrack) {
        this.updateForm(habitTrack);
      }
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const habitTrack = this.habitTrackFormService.getHabitTrack(this.editForm);
    if (habitTrack.id !== null) {
      this.subscribeToSaveResponse(this.habitTrackService.update(habitTrack));
    } else {
      this.subscribeToSaveResponse(this.habitTrackService.create(habitTrack));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IHabitTrack>>): void {
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

  protected updateForm(habitTrack: IHabitTrack): void {
    this.habitTrack = habitTrack;
    this.habitTrackFormService.resetForm(this.editForm, habitTrack);
  }
}
