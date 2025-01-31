import { TestBed } from '@angular/core/testing';

import { sampleWithNewData, sampleWithRequiredData } from '../media-content.test-samples';

import { MediaContentFormService } from './media-content-form.service';

describe('MediaContent Form Service', () => {
  let service: MediaContentFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MediaContentFormService);
  });

  describe('Service methods', () => {
    describe('createMediaContentFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createMediaContentFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            text: expect.any(Object),
            audio: expect.any(Object),
            uploadDateTime: expect.any(Object),
            language: expect.any(Object),
            difficultyLevel: expect.any(Object),
          }),
        );
      });

      it('passing IMediaContent should create a new form with FormGroup', () => {
        const formGroup = service.createMediaContentFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            text: expect.any(Object),
            audio: expect.any(Object),
            uploadDateTime: expect.any(Object),
            language: expect.any(Object),
            difficultyLevel: expect.any(Object),
          }),
        );
      });
    });

    describe('getMediaContent', () => {
      it('should return NewMediaContent for default MediaContent initial value', () => {
        const formGroup = service.createMediaContentFormGroup(sampleWithNewData);

        const mediaContent = service.getMediaContent(formGroup) as any;

        expect(mediaContent).toMatchObject(sampleWithNewData);
      });

      it('should return NewMediaContent for empty MediaContent initial value', () => {
        const formGroup = service.createMediaContentFormGroup();

        const mediaContent = service.getMediaContent(formGroup) as any;

        expect(mediaContent).toMatchObject({});
      });

      it('should return IMediaContent', () => {
        const formGroup = service.createMediaContentFormGroup(sampleWithRequiredData);

        const mediaContent = service.getMediaContent(formGroup) as any;

        expect(mediaContent).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IMediaContent should not enable id FormControl', () => {
        const formGroup = service.createMediaContentFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewMediaContent should disable id FormControl', () => {
        const formGroup = service.createMediaContentFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
