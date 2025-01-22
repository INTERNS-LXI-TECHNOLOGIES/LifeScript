import { Component, OnInit, inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IPerfectDay } from '../perfect-day.model';
import { PerfectDayService } from '../service/perfect-day.service';
import { PerfectDayFormGroup, PerfectDayFormService } from './perfect-day-form.service';

@Component({
  selector: 'jhi-perfect-day-update',
  templateUrl: './perfect-day-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class PerfectDayUpdateComponent implements OnInit {
  isSaving = false;
  perfectDay: IPerfectDay | null = null;

  protected perfectDayService = inject(PerfectDayService);
  protected perfectDayFormService = inject(PerfectDayFormService);
  protected activatedRoute = inject(ActivatedRoute);

  // eslint-disable-next-line @typescript-eslint/member-ordering
  editForm: PerfectDayFormGroup = this.perfectDayFormService.createPerfectDayFormGroup();

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ perfectDay }) => {
      this.perfectDay = perfectDay;
      if (perfectDay) {
        this.updateForm(perfectDay);
      }
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const perfectDay = this.perfectDayFormService.getPerfectDay(this.editForm);
    if (perfectDay.id !== null) {
      this.subscribeToSaveResponse(this.perfectDayService.update(perfectDay));
    } else {
      this.subscribeToSaveResponse(this.perfectDayService.create(perfectDay));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IPerfectDay>>): void {
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

  protected updateForm(perfectDay: IPerfectDay): void {
    this.perfectDay = perfectDay;
    this.perfectDayFormService.resetForm(this.editForm, perfectDay);
  }
}
