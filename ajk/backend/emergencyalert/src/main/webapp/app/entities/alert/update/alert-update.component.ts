import { Component, OnInit, inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize, map } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IChild } from 'app/entities/child/child.model';
import { ChildService } from 'app/entities/child/service/child.service';
import { IAlert } from '../alert.model';
import { AlertService } from '../service/alert.service';
import { AlertFormGroup, AlertFormService } from './alert-form.service';

@Component({
  selector: 'jhi-alert-update',
  templateUrl: './alert-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class AlertUpdateComponent implements OnInit {
  isSaving = false;
  alert: IAlert | null = null;

  childrenSharedCollection: IChild[] = [];

  protected alertService = inject(AlertService);
  protected alertFormService = inject(AlertFormService);
  protected childService = inject(ChildService);
  protected activatedRoute = inject(ActivatedRoute);

  // eslint-disable-next-line @typescript-eslint/member-ordering
  editForm: AlertFormGroup = this.alertFormService.createAlertFormGroup();

  compareChild = (o1: IChild | null, o2: IChild | null): boolean => this.childService.compareChild(o1, o2);

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ alert }) => {
      this.alert = alert;
      if (alert) {
        this.updateForm(alert);
      }

      this.loadRelationshipsOptions();
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const alert = this.alertFormService.getAlert(this.editForm);
    if (alert.id !== null) {
      this.subscribeToSaveResponse(this.alertService.update(alert));
    } else {
      this.subscribeToSaveResponse(this.alertService.create(alert));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IAlert>>): void {
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

  protected updateForm(alert: IAlert): void {
    this.alert = alert;
    this.alertFormService.resetForm(this.editForm, alert);

    this.childrenSharedCollection = this.childService.addChildToCollectionIfMissing<IChild>(this.childrenSharedCollection, alert.child);
  }

  protected loadRelationshipsOptions(): void {
    this.childService
      .query()
      .pipe(map((res: HttpResponse<IChild[]>) => res.body ?? []))
      .pipe(map((children: IChild[]) => this.childService.addChildToCollectionIfMissing<IChild>(children, this.alert?.child)))
      .subscribe((children: IChild[]) => (this.childrenSharedCollection = children));
  }
}
