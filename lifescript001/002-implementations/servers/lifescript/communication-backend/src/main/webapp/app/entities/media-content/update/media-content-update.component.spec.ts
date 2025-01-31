import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { MediaContentService } from '../service/media-content.service';
import { IMediaContent } from '../media-content.model';
import { MediaContentFormService } from './media-content-form.service';

import { MediaContentUpdateComponent } from './media-content-update.component';

describe('MediaContent Management Update Component', () => {
  let comp: MediaContentUpdateComponent;
  let fixture: ComponentFixture<MediaContentUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let mediaContentFormService: MediaContentFormService;
  let mediaContentService: MediaContentService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [MediaContentUpdateComponent],
      providers: [
        provideHttpClient(),
        FormBuilder,
        {
          provide: ActivatedRoute,
          useValue: {
            params: from([{}]),
          },
        },
      ],
    })
      .overrideTemplate(MediaContentUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(MediaContentUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    mediaContentFormService = TestBed.inject(MediaContentFormService);
    mediaContentService = TestBed.inject(MediaContentService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const mediaContent: IMediaContent = { id: 11668 };

      activatedRoute.data = of({ mediaContent });
      comp.ngOnInit();

      expect(comp.mediaContent).toEqual(mediaContent);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IMediaContent>>();
      const mediaContent = { id: 31411 };
      jest.spyOn(mediaContentFormService, 'getMediaContent').mockReturnValue(mediaContent);
      jest.spyOn(mediaContentService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ mediaContent });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: mediaContent }));
      saveSubject.complete();

      // THEN
      expect(mediaContentFormService.getMediaContent).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(mediaContentService.update).toHaveBeenCalledWith(expect.objectContaining(mediaContent));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IMediaContent>>();
      const mediaContent = { id: 31411 };
      jest.spyOn(mediaContentFormService, 'getMediaContent').mockReturnValue({ id: null });
      jest.spyOn(mediaContentService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ mediaContent: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: mediaContent }));
      saveSubject.complete();

      // THEN
      expect(mediaContentFormService.getMediaContent).toHaveBeenCalled();
      expect(mediaContentService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IMediaContent>>();
      const mediaContent = { id: 31411 };
      jest.spyOn(mediaContentService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ mediaContent });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(mediaContentService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
