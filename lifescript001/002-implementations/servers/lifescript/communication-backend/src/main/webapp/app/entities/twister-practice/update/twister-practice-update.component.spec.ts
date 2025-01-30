import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { IMediaContent } from 'app/entities/media-content/media-content.model';
import { MediaContentService } from 'app/entities/media-content/service/media-content.service';
import { TwisterPracticeService } from '../service/twister-practice.service';
import { ITwisterPractice } from '../twister-practice.model';
import { TwisterPracticeFormService } from './twister-practice-form.service';

import { TwisterPracticeUpdateComponent } from './twister-practice-update.component';

describe('TwisterPractice Management Update Component', () => {
  let comp: TwisterPracticeUpdateComponent;
  let fixture: ComponentFixture<TwisterPracticeUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let twisterPracticeFormService: TwisterPracticeFormService;
  let twisterPracticeService: TwisterPracticeService;
  let mediaContentService: MediaContentService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [TwisterPracticeUpdateComponent],
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
      .overrideTemplate(TwisterPracticeUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(TwisterPracticeUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    twisterPracticeFormService = TestBed.inject(TwisterPracticeFormService);
    twisterPracticeService = TestBed.inject(TwisterPracticeService);
    mediaContentService = TestBed.inject(MediaContentService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should call MediaContent query and add missing value', () => {
      const twisterPractice: ITwisterPractice = { id: 30383 };
      const mediaContent: IMediaContent = { id: 31411 };
      twisterPractice.mediaContent = mediaContent;

      const mediaContentCollection: IMediaContent[] = [{ id: 31411 }];
      jest.spyOn(mediaContentService, 'query').mockReturnValue(of(new HttpResponse({ body: mediaContentCollection })));
      const additionalMediaContents = [mediaContent];
      const expectedCollection: IMediaContent[] = [...additionalMediaContents, ...mediaContentCollection];
      jest.spyOn(mediaContentService, 'addMediaContentToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ twisterPractice });
      comp.ngOnInit();

      expect(mediaContentService.query).toHaveBeenCalled();
      expect(mediaContentService.addMediaContentToCollectionIfMissing).toHaveBeenCalledWith(
        mediaContentCollection,
        ...additionalMediaContents.map(expect.objectContaining),
      );
      expect(comp.mediaContentsSharedCollection).toEqual(expectedCollection);
    });

    it('Should update editForm', () => {
      const twisterPractice: ITwisterPractice = { id: 30383 };
      const mediaContent: IMediaContent = { id: 31411 };
      twisterPractice.mediaContent = mediaContent;

      activatedRoute.data = of({ twisterPractice });
      comp.ngOnInit();

      expect(comp.mediaContentsSharedCollection).toContainEqual(mediaContent);
      expect(comp.twisterPractice).toEqual(twisterPractice);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ITwisterPractice>>();
      const twisterPractice = { id: 11105 };
      jest.spyOn(twisterPracticeFormService, 'getTwisterPractice').mockReturnValue(twisterPractice);
      jest.spyOn(twisterPracticeService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ twisterPractice });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: twisterPractice }));
      saveSubject.complete();

      // THEN
      expect(twisterPracticeFormService.getTwisterPractice).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(twisterPracticeService.update).toHaveBeenCalledWith(expect.objectContaining(twisterPractice));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ITwisterPractice>>();
      const twisterPractice = { id: 11105 };
      jest.spyOn(twisterPracticeFormService, 'getTwisterPractice').mockReturnValue({ id: null });
      jest.spyOn(twisterPracticeService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ twisterPractice: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: twisterPractice }));
      saveSubject.complete();

      // THEN
      expect(twisterPracticeFormService.getTwisterPractice).toHaveBeenCalled();
      expect(twisterPracticeService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ITwisterPractice>>();
      const twisterPractice = { id: 11105 };
      jest.spyOn(twisterPracticeService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ twisterPractice });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(twisterPracticeService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });

  describe('Compare relationships', () => {
    describe('compareMediaContent', () => {
      it('Should forward to mediaContentService', () => {
        const entity = { id: 31411 };
        const entity2 = { id: 11668 };
        jest.spyOn(mediaContentService, 'compareMediaContent');
        comp.compareMediaContent(entity, entity2);
        expect(mediaContentService.compareMediaContent).toHaveBeenCalledWith(entity, entity2);
      });
    });
  });
});
