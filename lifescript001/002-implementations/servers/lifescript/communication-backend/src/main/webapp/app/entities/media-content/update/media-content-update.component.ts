import { Component, OnInit, inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { AlertError } from 'app/shared/alert/alert-error.model';
import { EventManager, EventWithContent } from 'app/core/util/event-manager.service';
import { DataUtils, FileLoadError } from 'app/core/util/data-util.service';
import { MediaContentService } from '../service/media-content.service';
import { IMediaContent } from '../media-content.model';
import { MediaContentFormGroup, MediaContentFormService } from './media-content-form.service';

@Component({
  selector: 'jhi-media-content-update',
  templateUrl: './media-content-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class MediaContentUpdateComponent implements OnInit {
  isSaving = false;
  mediaContent: IMediaContent | null = null;

  protected dataUtils = inject(DataUtils);
  protected eventManager = inject(EventManager);
  protected mediaContentService = inject(MediaContentService);
  protected mediaContentFormService = inject(MediaContentFormService);
  protected activatedRoute = inject(ActivatedRoute);

  // eslint-disable-next-line @typescript-eslint/member-ordering
  editForm: MediaContentFormGroup = this.mediaContentFormService.createMediaContentFormGroup();

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ mediaContent }) => {
      this.mediaContent = mediaContent;
      if (mediaContent) {
        this.updateForm(mediaContent);
      }
    });
  }

  byteSize(base64String: string): string {
    return this.dataUtils.byteSize(base64String);
  }

  openFile(base64String: string, contentType: string | null | undefined): void {
    this.dataUtils.openFile(base64String, contentType);
  }

  setFileData(event: Event, field: string, isImage: boolean): void {
    this.dataUtils.loadFileToForm(event, this.editForm, field, isImage).subscribe({
      error: (err: FileLoadError) =>
        this.eventManager.broadcast(
          new EventWithContent<AlertError>('communicationBackendApp.error', { ...err, key: `error.file.${err.key}` }),
        ),
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const mediaContent = this.mediaContentFormService.getMediaContent(this.editForm);
    if (mediaContent.id !== null) {
      this.subscribeToSaveResponse(this.mediaContentService.update(mediaContent));
    } else {
      this.subscribeToSaveResponse(this.mediaContentService.create(mediaContent));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IMediaContent>>): void {
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

  protected updateForm(mediaContent: IMediaContent): void {
    this.mediaContent = mediaContent;
    this.mediaContentFormService.resetForm(this.editForm, mediaContent);
  }
}
