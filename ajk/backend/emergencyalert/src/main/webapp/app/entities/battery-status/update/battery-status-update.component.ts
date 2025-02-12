import { Component, OnInit, inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IBatteryStatus } from '../battery-status.model';
import { BatteryStatusService } from '../service/battery-status.service';
import { BatteryStatusFormGroup, BatteryStatusFormService } from './battery-status-form.service';

@Component({
  selector: 'jhi-battery-status-update',
  templateUrl: './battery-status-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class BatteryStatusUpdateComponent implements OnInit {
  isSaving = false;
  batteryStatus: IBatteryStatus | null = null;

  protected batteryStatusService = inject(BatteryStatusService);
  protected batteryStatusFormService = inject(BatteryStatusFormService);
  protected activatedRoute = inject(ActivatedRoute);

  // eslint-disable-next-line @typescript-eslint/member-ordering
  editForm: BatteryStatusFormGroup = this.batteryStatusFormService.createBatteryStatusFormGroup();

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ batteryStatus }) => {
      this.batteryStatus = batteryStatus;
      if (batteryStatus) {
        this.updateForm(batteryStatus);
      }
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const batteryStatus = this.batteryStatusFormService.getBatteryStatus(this.editForm);
    if (batteryStatus.id !== null) {
      this.subscribeToSaveResponse(this.batteryStatusService.update(batteryStatus));
    } else {
      this.subscribeToSaveResponse(this.batteryStatusService.create(batteryStatus));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IBatteryStatus>>): void {
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

  protected updateForm(batteryStatus: IBatteryStatus): void {
    this.batteryStatus = batteryStatus;
    this.batteryStatusFormService.resetForm(this.editForm, batteryStatus);
  }
}
