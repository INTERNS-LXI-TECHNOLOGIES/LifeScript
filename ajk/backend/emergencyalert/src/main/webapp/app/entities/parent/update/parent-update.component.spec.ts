import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { ParentService } from '../service/parent.service';
import { IParent } from '../parent.model';
import { ParentFormService } from './parent-form.service';

import { ParentUpdateComponent } from './parent-update.component';

describe('Parent Management Update Component', () => {
  let comp: ParentUpdateComponent;
  let fixture: ComponentFixture<ParentUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let parentFormService: ParentFormService;
  let parentService: ParentService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [ParentUpdateComponent],
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
      .overrideTemplate(ParentUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(ParentUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    parentFormService = TestBed.inject(ParentFormService);
    parentService = TestBed.inject(ParentService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const parent: IParent = { id: 2353 };

      activatedRoute.data = of({ parent });
      comp.ngOnInit();

      expect(comp.parent).toEqual(parent);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IParent>>();
      const parent = { id: 10134 };
      jest.spyOn(parentFormService, 'getParent').mockReturnValue(parent);
      jest.spyOn(parentService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ parent });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: parent }));
      saveSubject.complete();

      // THEN
      expect(parentFormService.getParent).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(parentService.update).toHaveBeenCalledWith(expect.objectContaining(parent));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IParent>>();
      const parent = { id: 10134 };
      jest.spyOn(parentFormService, 'getParent').mockReturnValue({ id: null });
      jest.spyOn(parentService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ parent: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: parent }));
      saveSubject.complete();

      // THEN
      expect(parentFormService.getParent).toHaveBeenCalled();
      expect(parentService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IParent>>();
      const parent = { id: 10134 };
      jest.spyOn(parentService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ parent });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(parentService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
