import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { HabitTrackService } from '../service/habit-track.service';
import { IHabitTrack } from '../habit-track.model';
import { HabitTrackFormService } from './habit-track-form.service';

import { HabitTrackUpdateComponent } from './habit-track-update.component';

describe('HabitTrack Management Update Component', () => {
  let comp: HabitTrackUpdateComponent;
  let fixture: ComponentFixture<HabitTrackUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let habitTrackFormService: HabitTrackFormService;
  let habitTrackService: HabitTrackService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HabitTrackUpdateComponent],
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
      .overrideTemplate(HabitTrackUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(HabitTrackUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    habitTrackFormService = TestBed.inject(HabitTrackFormService);
    habitTrackService = TestBed.inject(HabitTrackService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const habitTrack: IHabitTrack = { id: 32282 };

      activatedRoute.data = of({ habitTrack });
      comp.ngOnInit();

      expect(comp.habitTrack).toEqual(habitTrack);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IHabitTrack>>();
      const habitTrack = { id: 21546 };
      jest.spyOn(habitTrackFormService, 'getHabitTrack').mockReturnValue(habitTrack);
      jest.spyOn(habitTrackService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ habitTrack });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: habitTrack }));
      saveSubject.complete();

      // THEN
      expect(habitTrackFormService.getHabitTrack).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(habitTrackService.update).toHaveBeenCalledWith(expect.objectContaining(habitTrack));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IHabitTrack>>();
      const habitTrack = { id: 21546 };
      jest.spyOn(habitTrackFormService, 'getHabitTrack').mockReturnValue({ id: null });
      jest.spyOn(habitTrackService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ habitTrack: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: habitTrack }));
      saveSubject.complete();

      // THEN
      expect(habitTrackFormService.getHabitTrack).toHaveBeenCalled();
      expect(habitTrackService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IHabitTrack>>();
      const habitTrack = { id: 21546 };
      jest.spyOn(habitTrackService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ habitTrack });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(habitTrackService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
