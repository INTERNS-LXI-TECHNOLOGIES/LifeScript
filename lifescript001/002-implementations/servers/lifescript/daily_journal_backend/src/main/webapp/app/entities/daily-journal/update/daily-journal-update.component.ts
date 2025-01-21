import { Component, OnInit } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IDailyJournal } from '../daily-journal.model';
import { DailyJournalService } from '../service/daily-journal.service';
import { DailyJournalFormService, DailyJournalFormGroup } from './daily-journal-form.service';

@Component({
  standalone: true,
  selector: 'jhi-daily-journal-update',
  templateUrl: './daily-journal-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class DailyJournalUpdateComponent implements OnInit {
  isSaving = false;
  dailyJournal: IDailyJournal | null = null;

  editForm: DailyJournalFormGroup = this.dailyJournalFormService.createDailyJournalFormGroup();

  constructor(
    protected dailyJournalService: DailyJournalService,
    protected dailyJournalFormService: DailyJournalFormService,
    protected activatedRoute: ActivatedRoute,
  ) {}

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ dailyJournal }) => {
      this.dailyJournal = dailyJournal;
      if (dailyJournal) {
        this.updateForm(dailyJournal);
      }
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const dailyJournal = this.dailyJournalFormService.getDailyJournal(this.editForm);
    if (dailyJournal.id !== null) {
      this.subscribeToSaveResponse(this.dailyJournalService.update(dailyJournal));
    } else {
      this.subscribeToSaveResponse(this.dailyJournalService.create(dailyJournal));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IDailyJournal>>): void {
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

  protected updateForm(dailyJournal: IDailyJournal): void {
    this.dailyJournal = dailyJournal;
    this.dailyJournalFormService.resetForm(this.editForm, dailyJournal);
  }
}
