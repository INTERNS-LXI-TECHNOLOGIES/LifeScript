import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import dayjs from 'dayjs/esm';
import { DATE_TIME_FORMAT } from 'app/config/input.constants';
import { IMediaContent, NewMediaContent } from '../media-content.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IMediaContent for edit and NewMediaContentFormGroupInput for create.
 */
type MediaContentFormGroupInput = IMediaContent | PartialWithRequiredKeyOf<NewMediaContent>;

/**
 * Type that converts some properties for forms.
 */
type FormValueOf<T extends IMediaContent | NewMediaContent> = Omit<T, 'uploadDateTime'> & {
  uploadDateTime?: string | null;
};

type MediaContentFormRawValue = FormValueOf<IMediaContent>;

type NewMediaContentFormRawValue = FormValueOf<NewMediaContent>;

type MediaContentFormDefaults = Pick<NewMediaContent, 'id' | 'uploadDateTime'>;

type MediaContentFormGroupContent = {
  id: FormControl<MediaContentFormRawValue['id'] | NewMediaContent['id']>;
  text: FormControl<MediaContentFormRawValue['text']>;
  audio: FormControl<MediaContentFormRawValue['audio']>;
  audioContentType: FormControl<MediaContentFormRawValue['audioContentType']>;
  uploadDateTime: FormControl<MediaContentFormRawValue['uploadDateTime']>;
  language: FormControl<MediaContentFormRawValue['language']>;
  difficultyLevel: FormControl<MediaContentFormRawValue['difficultyLevel']>;
};

export type MediaContentFormGroup = FormGroup<MediaContentFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class MediaContentFormService {
  createMediaContentFormGroup(mediaContent: MediaContentFormGroupInput = { id: null }): MediaContentFormGroup {
    const mediaContentRawValue = this.convertMediaContentToMediaContentRawValue({
      ...this.getFormDefaults(),
      ...mediaContent,
    });
    return new FormGroup<MediaContentFormGroupContent>({
      id: new FormControl(
        { value: mediaContentRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      text: new FormControl(mediaContentRawValue.text),
      audio: new FormControl(mediaContentRawValue.audio),
      audioContentType: new FormControl(mediaContentRawValue.audioContentType),
      uploadDateTime: new FormControl(mediaContentRawValue.uploadDateTime),
      language: new FormControl(mediaContentRawValue.language, {
        validators: [Validators.required],
      }),
      difficultyLevel: new FormControl(mediaContentRawValue.difficultyLevel, {
        validators: [Validators.required],
      }),
    });
  }

  getMediaContent(form: MediaContentFormGroup): IMediaContent | NewMediaContent {
    return this.convertMediaContentRawValueToMediaContent(form.getRawValue() as MediaContentFormRawValue | NewMediaContentFormRawValue);
  }

  resetForm(form: MediaContentFormGroup, mediaContent: MediaContentFormGroupInput): void {
    const mediaContentRawValue = this.convertMediaContentToMediaContentRawValue({ ...this.getFormDefaults(), ...mediaContent });
    form.reset(
      {
        ...mediaContentRawValue,
        id: { value: mediaContentRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): MediaContentFormDefaults {
    const currentTime = dayjs();

    return {
      id: null,
      uploadDateTime: currentTime,
    };
  }

  private convertMediaContentRawValueToMediaContent(
    rawMediaContent: MediaContentFormRawValue | NewMediaContentFormRawValue,
  ): IMediaContent | NewMediaContent {
    return {
      ...rawMediaContent,
      uploadDateTime: dayjs(rawMediaContent.uploadDateTime, DATE_TIME_FORMAT),
    };
  }

  private convertMediaContentToMediaContentRawValue(
    mediaContent: IMediaContent | (Partial<NewMediaContent> & MediaContentFormDefaults),
  ): MediaContentFormRawValue | PartialWithRequiredKeyOf<NewMediaContentFormRawValue> {
    return {
      ...mediaContent,
      uploadDateTime: mediaContent.uploadDateTime ? mediaContent.uploadDateTime.format(DATE_TIME_FORMAT) : undefined,
    };
  }
}
