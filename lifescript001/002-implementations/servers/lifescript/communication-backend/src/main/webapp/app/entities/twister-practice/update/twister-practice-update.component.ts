import { Component, OnInit, inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize, map } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IMediaContent } from 'app/entities/media-content/media-content.model';
import { MediaContentService } from 'app/entities/media-content/service/media-content.service';
import { ITwisterPractice } from '../twister-practice.model';
import { TwisterPracticeService } from '../service/twister-practice.service';
import { TwisterPracticeFormGroup, TwisterPracticeFormService } from './twister-practice-form.service';

@Component({
  selector: 'jhi-twister-practice-update',
  templateUrl: './twister-practice-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class TwisterPracticeUpdateComponent implements OnInit {
  isSaving = false;
  twisterPractice: ITwisterPractice | null = null;

  mediaContentsSharedCollection: IMediaContent[] = [];

  protected twisterPracticeService = inject(TwisterPracticeService);
  protected twisterPracticeFormService = inject(TwisterPracticeFormService);
  protected mediaContentService = inject(MediaContentService);
  protected activatedRoute = inject(ActivatedRoute);

  // eslint-disable-next-line @typescript-eslint/member-ordering
  editForm: TwisterPracticeFormGroup = this.twisterPracticeFormService.createTwisterPracticeFormGroup();

  compareMediaContent = (o1: IMediaContent | null, o2: IMediaContent | null): boolean =>
    this.mediaContentService.compareMediaContent(o1, o2);

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ twisterPractice }) => {
      this.twisterPractice = twisterPractice;
      if (twisterPractice) {
        this.updateForm(twisterPractice);
      }

      this.loadRelationshipsOptions();
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const twisterPractice = this.twisterPracticeFormService.getTwisterPractice(this.editForm);
    if (twisterPractice.id !== null) {
      this.subscribeToSaveResponse(this.twisterPracticeService.update(twisterPractice));
    } else {
      this.subscribeToSaveResponse(this.twisterPracticeService.create(twisterPractice));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<ITwisterPractice>>): void {
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

  protected updateForm(twisterPractice: ITwisterPractice): void {
    this.twisterPractice = twisterPractice;
    this.twisterPracticeFormService.resetForm(this.editForm, twisterPractice);

    this.mediaContentsSharedCollection = this.mediaContentService.addMediaContentToCollectionIfMissing<IMediaContent>(
      this.mediaContentsSharedCollection,
      twisterPractice.mediaContent,
    );
  }

  protected loadRelationshipsOptions(): void {
    this.mediaContentService
      .query()
      .pipe(map((res: HttpResponse<IMediaContent[]>) => res.body ?? []))
      .pipe(
        map((mediaContents: IMediaContent[]) =>
          this.mediaContentService.addMediaContentToCollectionIfMissing<IMediaContent>(mediaContents, this.twisterPractice?.mediaContent),
        ),
      )
      .subscribe((mediaContents: IMediaContent[]) => (this.mediaContentsSharedCollection = mediaContents));
  }
}
