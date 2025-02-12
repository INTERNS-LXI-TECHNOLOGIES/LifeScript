import { Component, OnInit, inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize, map } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IChild } from 'app/entities/child/child.model';
import { ChildService } from 'app/entities/child/service/child.service';
import { IGpsEntry } from '../gps-entry.model';
import { GpsEntryService } from '../service/gps-entry.service';
import { GpsEntryFormGroup, GpsEntryFormService } from './gps-entry-form.service';

@Component({
  selector: 'jhi-gps-entry-update',
  templateUrl: './gps-entry-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class GpsEntryUpdateComponent implements OnInit {
  isSaving = false;
  gpsEntry: IGpsEntry | null = null;

  childrenSharedCollection: IChild[] = [];

  protected gpsEntryService = inject(GpsEntryService);
  protected gpsEntryFormService = inject(GpsEntryFormService);
  protected childService = inject(ChildService);
  protected activatedRoute = inject(ActivatedRoute);

  // eslint-disable-next-line @typescript-eslint/member-ordering
  editForm: GpsEntryFormGroup = this.gpsEntryFormService.createGpsEntryFormGroup();

  compareChild = (o1: IChild | null, o2: IChild | null): boolean => this.childService.compareChild(o1, o2);

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ gpsEntry }) => {
      this.gpsEntry = gpsEntry;
      if (gpsEntry) {
        this.updateForm(gpsEntry);
      }

      this.loadRelationshipsOptions();
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const gpsEntry = this.gpsEntryFormService.getGpsEntry(this.editForm);
    if (gpsEntry.id !== null) {
      this.subscribeToSaveResponse(this.gpsEntryService.update(gpsEntry));
    } else {
      this.subscribeToSaveResponse(this.gpsEntryService.create(gpsEntry));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IGpsEntry>>): void {
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

  protected updateForm(gpsEntry: IGpsEntry): void {
    this.gpsEntry = gpsEntry;
    this.gpsEntryFormService.resetForm(this.editForm, gpsEntry);

    this.childrenSharedCollection = this.childService.addChildToCollectionIfMissing<IChild>(this.childrenSharedCollection, gpsEntry.child);
  }

  protected loadRelationshipsOptions(): void {
    this.childService
      .query()
      .pipe(map((res: HttpResponse<IChild[]>) => res.body ?? []))
      .pipe(map((children: IChild[]) => this.childService.addChildToCollectionIfMissing<IChild>(children, this.gpsEntry?.child)))
      .subscribe((children: IChild[]) => (this.childrenSharedCollection = children));
  }
}
