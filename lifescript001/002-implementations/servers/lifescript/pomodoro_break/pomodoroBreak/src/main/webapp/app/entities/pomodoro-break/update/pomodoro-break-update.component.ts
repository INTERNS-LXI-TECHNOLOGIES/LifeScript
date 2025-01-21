import { Component, OnInit, inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IPomodoroBreak } from '../pomodoro-break.model';
import { PomodoroBreakService } from '../service/pomodoro-break.service';
import { PomodoroBreakFormGroup, PomodoroBreakFormService } from './pomodoro-break-form.service';

@Component({
  selector: 'jhi-pomodoro-break-update',
  templateUrl: './pomodoro-break-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class PomodoroBreakUpdateComponent implements OnInit {
  isSaving = false;
  pomodoroBreak: IPomodoroBreak | null = null;

  protected pomodoroBreakService = inject(PomodoroBreakService);
  protected pomodoroBreakFormService = inject(PomodoroBreakFormService);
  protected activatedRoute = inject(ActivatedRoute);

  // eslint-disable-next-line @typescript-eslint/member-ordering
  editForm: PomodoroBreakFormGroup = this.pomodoroBreakFormService.createPomodoroBreakFormGroup();

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ pomodoroBreak }) => {
      this.pomodoroBreak = pomodoroBreak;
      if (pomodoroBreak) {
        this.updateForm(pomodoroBreak);
      }
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const pomodoroBreak = this.pomodoroBreakFormService.getPomodoroBreak(this.editForm);
    if (pomodoroBreak.id !== null) {
      this.subscribeToSaveResponse(this.pomodoroBreakService.update(pomodoroBreak));
    } else {
      this.subscribeToSaveResponse(this.pomodoroBreakService.create(pomodoroBreak));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IPomodoroBreak>>): void {
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

  protected updateForm(pomodoroBreak: IPomodoroBreak): void {
    this.pomodoroBreak = pomodoroBreak;
    this.pomodoroBreakFormService.resetForm(this.editForm, pomodoroBreak);
  }
}
