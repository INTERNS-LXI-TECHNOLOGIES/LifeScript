import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { PomodoroBreakService } from '../service/pomodoro-break.service';
import { IPomodoroBreak } from '../pomodoro-break.model';
import { PomodoroBreakFormService } from './pomodoro-break-form.service';

import { PomodoroBreakUpdateComponent } from './pomodoro-break-update.component';

describe('PomodoroBreak Management Update Component', () => {
  let comp: PomodoroBreakUpdateComponent;
  let fixture: ComponentFixture<PomodoroBreakUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let pomodoroBreakFormService: PomodoroBreakFormService;
  let pomodoroBreakService: PomodoroBreakService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [PomodoroBreakUpdateComponent],
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
      .overrideTemplate(PomodoroBreakUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(PomodoroBreakUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    pomodoroBreakFormService = TestBed.inject(PomodoroBreakFormService);
    pomodoroBreakService = TestBed.inject(PomodoroBreakService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const pomodoroBreak: IPomodoroBreak = { id: 30212 };

      activatedRoute.data = of({ pomodoroBreak });
      comp.ngOnInit();

      expect(comp.pomodoroBreak).toEqual(pomodoroBreak);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IPomodoroBreak>>();
      const pomodoroBreak = { id: 1428 };
      jest.spyOn(pomodoroBreakFormService, 'getPomodoroBreak').mockReturnValue(pomodoroBreak);
      jest.spyOn(pomodoroBreakService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ pomodoroBreak });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: pomodoroBreak }));
      saveSubject.complete();

      // THEN
      expect(pomodoroBreakFormService.getPomodoroBreak).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(pomodoroBreakService.update).toHaveBeenCalledWith(expect.objectContaining(pomodoroBreak));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IPomodoroBreak>>();
      const pomodoroBreak = { id: 1428 };
      jest.spyOn(pomodoroBreakFormService, 'getPomodoroBreak').mockReturnValue({ id: null });
      jest.spyOn(pomodoroBreakService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ pomodoroBreak: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: pomodoroBreak }));
      saveSubject.complete();

      // THEN
      expect(pomodoroBreakFormService.getPomodoroBreak).toHaveBeenCalled();
      expect(pomodoroBreakService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IPomodoroBreak>>();
      const pomodoroBreak = { id: 1428 };
      jest.spyOn(pomodoroBreakService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ pomodoroBreak });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(pomodoroBreakService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
