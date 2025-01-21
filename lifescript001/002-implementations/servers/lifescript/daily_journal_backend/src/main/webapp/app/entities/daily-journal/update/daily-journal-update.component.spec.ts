import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of, Subject, from } from 'rxjs';

import { DailyJournalService } from '../service/daily-journal.service';
import { IDailyJournal } from '../daily-journal.model';
import { DailyJournalFormService } from './daily-journal-form.service';

import { DailyJournalUpdateComponent } from './daily-journal-update.component';

describe('DailyJournal Management Update Component', () => {
  let comp: DailyJournalUpdateComponent;
  let fixture: ComponentFixture<DailyJournalUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let dailyJournalFormService: DailyJournalFormService;
  let dailyJournalService: DailyJournalService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, RouterTestingModule.withRoutes([]), DailyJournalUpdateComponent],
      providers: [
        FormBuilder,
        {
          provide: ActivatedRoute,
          useValue: {
            params: from([{}]),
          },
        },
      ],
    })
      .overrideTemplate(DailyJournalUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(DailyJournalUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    dailyJournalFormService = TestBed.inject(DailyJournalFormService);
    dailyJournalService = TestBed.inject(DailyJournalService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const dailyJournal: IDailyJournal = { id: 456 };

      activatedRoute.data = of({ dailyJournal });
      comp.ngOnInit();

      expect(comp.dailyJournal).toEqual(dailyJournal);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IDailyJournal>>();
      const dailyJournal = { id: 123 };
      jest.spyOn(dailyJournalFormService, 'getDailyJournal').mockReturnValue(dailyJournal);
      jest.spyOn(dailyJournalService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ dailyJournal });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: dailyJournal }));
      saveSubject.complete();

      // THEN
      expect(dailyJournalFormService.getDailyJournal).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(dailyJournalService.update).toHaveBeenCalledWith(expect.objectContaining(dailyJournal));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IDailyJournal>>();
      const dailyJournal = { id: 123 };
      jest.spyOn(dailyJournalFormService, 'getDailyJournal').mockReturnValue({ id: null });
      jest.spyOn(dailyJournalService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ dailyJournal: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: dailyJournal }));
      saveSubject.complete();

      // THEN
      expect(dailyJournalFormService.getDailyJournal).toHaveBeenCalled();
      expect(dailyJournalService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IDailyJournal>>();
      const dailyJournal = { id: 123 };
      jest.spyOn(dailyJournalService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ dailyJournal });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(dailyJournalService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
