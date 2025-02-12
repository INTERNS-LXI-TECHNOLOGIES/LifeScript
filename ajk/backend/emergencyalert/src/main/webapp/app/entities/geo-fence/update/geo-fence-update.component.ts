import { Component, OnInit, inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IGeoFence } from '../geo-fence.model';
import { GeoFenceService } from '../service/geo-fence.service';
import { GeoFenceFormGroup, GeoFenceFormService } from './geo-fence-form.service';

@Component({
  selector: 'jhi-geo-fence-update',
  templateUrl: './geo-fence-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class GeoFenceUpdateComponent implements OnInit {
  isSaving = false;
  geoFence: IGeoFence | null = null;

  protected geoFenceService = inject(GeoFenceService);
  protected geoFenceFormService = inject(GeoFenceFormService);
  protected activatedRoute = inject(ActivatedRoute);

  // eslint-disable-next-line @typescript-eslint/member-ordering
  editForm: GeoFenceFormGroup = this.geoFenceFormService.createGeoFenceFormGroup();

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ geoFence }) => {
      this.geoFence = geoFence;
      if (geoFence) {
        this.updateForm(geoFence);
      }
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const geoFence = this.geoFenceFormService.getGeoFence(this.editForm);
    if (geoFence.id !== null) {
      this.subscribeToSaveResponse(this.geoFenceService.update(geoFence));
    } else {
      this.subscribeToSaveResponse(this.geoFenceService.create(geoFence));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IGeoFence>>): void {
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

  protected updateForm(geoFence: IGeoFence): void {
    this.geoFence = geoFence;
    this.geoFenceFormService.resetForm(this.editForm, geoFence);
  }
}
