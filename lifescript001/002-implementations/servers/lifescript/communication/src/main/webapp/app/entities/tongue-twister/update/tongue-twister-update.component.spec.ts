import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { TongueTwisterService } from '../service/tongue-twister.service';
import { ITongueTwister } from '../tongue-twister.model';
import { TongueTwisterFormService } from './tongue-twister-form.service';

import { TongueTwisterUpdateComponent } from './tongue-twister-update.component';

describe('TongueTwister Management Update Component', () => {
  let comp: TongueTwisterUpdateComponent;
  let fixture: ComponentFixture<TongueTwisterUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let tongueTwisterFormService: TongueTwisterFormService;
  let tongueTwisterService: TongueTwisterService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [TongueTwisterUpdateComponent],
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
      .overrideTemplate(TongueTwisterUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(TongueTwisterUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    tongueTwisterFormService = TestBed.inject(TongueTwisterFormService);
    tongueTwisterService = TestBed.inject(TongueTwisterService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const tongueTwister: ITongueTwister = { id: 12635 };

      activatedRoute.data = of({ tongueTwister });
      comp.ngOnInit();

      expect(comp.tongueTwister).toEqual(tongueTwister);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ITongueTwister>>();
      const tongueTwister = { id: 1199 };
      jest.spyOn(tongueTwisterFormService, 'getTongueTwister').mockReturnValue(tongueTwister);
      jest.spyOn(tongueTwisterService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ tongueTwister });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: tongueTwister }));
      saveSubject.complete();

      // THEN
      expect(tongueTwisterFormService.getTongueTwister).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(tongueTwisterService.update).toHaveBeenCalledWith(expect.objectContaining(tongueTwister));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ITongueTwister>>();
      const tongueTwister = { id: 1199 };
      jest.spyOn(tongueTwisterFormService, 'getTongueTwister').mockReturnValue({ id: null });
      jest.spyOn(tongueTwisterService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ tongueTwister: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: tongueTwister }));
      saveSubject.complete();

      // THEN
      expect(tongueTwisterFormService.getTongueTwister).toHaveBeenCalled();
      expect(tongueTwisterService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ITongueTwister>>();
      const tongueTwister = { id: 1199 };
      jest.spyOn(tongueTwisterService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ tongueTwister });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(tongueTwisterService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
