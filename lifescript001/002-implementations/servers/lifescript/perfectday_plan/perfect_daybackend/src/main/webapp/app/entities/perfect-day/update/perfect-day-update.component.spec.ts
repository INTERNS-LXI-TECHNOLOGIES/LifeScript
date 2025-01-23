import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { PerfectDayService } from '../service/perfect-day.service';
import { IPerfectDay } from '../perfect-day.model';
import { PerfectDayFormService } from './perfect-day-form.service';

import { PerfectDayUpdateComponent } from './perfect-day-update.component';

describe('PerfectDay Management Update Component', () => {
  let comp: PerfectDayUpdateComponent;
  let fixture: ComponentFixture<PerfectDayUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let perfectDayFormService: PerfectDayFormService;
  let perfectDayService: PerfectDayService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [PerfectDayUpdateComponent],
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
      .overrideTemplate(PerfectDayUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(PerfectDayUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    perfectDayFormService = TestBed.inject(PerfectDayFormService);
    perfectDayService = TestBed.inject(PerfectDayService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const perfectDay: IPerfectDay = { id: 21128 };

      activatedRoute.data = of({ perfectDay });
      comp.ngOnInit();

      expect(comp.perfectDay).toEqual(perfectDay);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IPerfectDay>>();
      const perfectDay = { id: 28965 };
      jest.spyOn(perfectDayFormService, 'getPerfectDay').mockReturnValue(perfectDay);
      jest.spyOn(perfectDayService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ perfectDay });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: perfectDay }));
      saveSubject.complete();

      // THEN
      expect(perfectDayFormService.getPerfectDay).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(perfectDayService.update).toHaveBeenCalledWith(expect.objectContaining(perfectDay));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IPerfectDay>>();
      const perfectDay = { id: 28965 };
      jest.spyOn(perfectDayFormService, 'getPerfectDay').mockReturnValue({ id: null });
      jest.spyOn(perfectDayService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ perfectDay: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: perfectDay }));
      saveSubject.complete();

      // THEN
      expect(perfectDayFormService.getPerfectDay).toHaveBeenCalled();
      expect(perfectDayService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IPerfectDay>>();
      const perfectDay = { id: 28965 };
      jest.spyOn(perfectDayService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ perfectDay });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(perfectDayService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
