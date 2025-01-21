import { Component, OnInit, inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IHabitTracker } from '../habit-tracker.model';
import { HabitTrackerService } from '../service/habit-tracker.service';
import { HabitTrackerFormGroup, HabitTrackerFormService } from './habit-tracker-form.service';

@Component({
  selector: 'jhi-habit-tracker-update',
  templateUrl: './habit-tracker-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class HabitTrackerUpdateComponent implements OnInit {
  isSaving = false;
  habitTracker: IHabitTracker | null = null;

  protected habitTrackerService = inject(HabitTrackerService);
  protected habitTrackerFormService = inject(HabitTrackerFormService);
  protected activatedRoute = inject(ActivatedRoute);

  // eslint-disable-next-line @typescript-eslint/member-ordering
  editForm: HabitTrackerFormGroup = this.habitTrackerFormService.createHabitTrackerFormGroup();

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ habitTracker }) => {
      this.habitTracker = habitTracker;
      if (habitTracker) {
        this.updateForm(habitTracker);
      }
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const habitTracker = this.habitTrackerFormService.getHabitTracker(this.editForm);
    if (habitTracker.id !== null) {
      this.subscribeToSaveResponse(this.habitTrackerService.update(habitTracker));
    } else {
      this.subscribeToSaveResponse(this.habitTrackerService.create(habitTracker));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IHabitTracker>>): void {
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

  protected updateForm(habitTracker: IHabitTracker): void {
    this.habitTracker = habitTracker;
    this.habitTrackerFormService.resetForm(this.editForm, habitTracker);
  }
}
