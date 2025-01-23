import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { HabitTrackerService } from '../service/habit-tracker.service';
import { IHabitTracker } from '../habit-tracker.model';
import { HabitTrackerFormService } from './habit-tracker-form.service';

import { HabitTrackerUpdateComponent } from './habit-tracker-update.component';

describe('HabitTracker Management Update Component', () => {
  let comp: HabitTrackerUpdateComponent;
  let fixture: ComponentFixture<HabitTrackerUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let habitTrackerFormService: HabitTrackerFormService;
  let habitTrackerService: HabitTrackerService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HabitTrackerUpdateComponent],
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
      .overrideTemplate(HabitTrackerUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(HabitTrackerUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    habitTrackerFormService = TestBed.inject(HabitTrackerFormService);
    habitTrackerService = TestBed.inject(HabitTrackerService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const habitTracker: IHabitTracker = { id: 9673 };

      activatedRoute.data = of({ habitTracker });
      comp.ngOnInit();

      expect(comp.habitTracker).toEqual(habitTracker);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IHabitTracker>>();
      const habitTracker = { id: 10647 };
      jest.spyOn(habitTrackerFormService, 'getHabitTracker').mockReturnValue(habitTracker);
      jest.spyOn(habitTrackerService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ habitTracker });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: habitTracker }));
      saveSubject.complete();

      // THEN
      expect(habitTrackerFormService.getHabitTracker).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(habitTrackerService.update).toHaveBeenCalledWith(expect.objectContaining(habitTracker));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IHabitTracker>>();
      const habitTracker = { id: 10647 };
      jest.spyOn(habitTrackerFormService, 'getHabitTracker').mockReturnValue({ id: null });
      jest.spyOn(habitTrackerService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ habitTracker: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: habitTracker }));
      saveSubject.complete();

      // THEN
      expect(habitTrackerFormService.getHabitTracker).toHaveBeenCalled();
      expect(habitTrackerService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IHabitTracker>>();
      const habitTracker = { id: 10647 };
      jest.spyOn(habitTrackerService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ habitTracker });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(habitTrackerService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
