import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { IChild } from 'app/entities/child/child.model';
import { ChildService } from 'app/entities/child/service/child.service';
import { AlertService } from '../service/alert.service';
import { IAlert } from '../alert.model';
import { AlertFormService } from './alert-form.service';

import { AlertUpdateComponent } from './alert-update.component';

describe('Alert Management Update Component', () => {
  let comp: AlertUpdateComponent;
  let fixture: ComponentFixture<AlertUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let alertFormService: AlertFormService;
  let alertService: AlertService;
  let childService: ChildService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [AlertUpdateComponent],
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
      .overrideTemplate(AlertUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(AlertUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    alertFormService = TestBed.inject(AlertFormService);
    alertService = TestBed.inject(AlertService);
    childService = TestBed.inject(ChildService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should call Child query and add missing value', () => {
      const alert: IAlert = { id: 17171 };
      const child: IChild = { id: 19105 };
      alert.child = child;

      const childCollection: IChild[] = [{ id: 19105 }];
      jest.spyOn(childService, 'query').mockReturnValue(of(new HttpResponse({ body: childCollection })));
      const additionalChildren = [child];
      const expectedCollection: IChild[] = [...additionalChildren, ...childCollection];
      jest.spyOn(childService, 'addChildToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ alert });
      comp.ngOnInit();

      expect(childService.query).toHaveBeenCalled();
      expect(childService.addChildToCollectionIfMissing).toHaveBeenCalledWith(
        childCollection,
        ...additionalChildren.map(expect.objectContaining),
      );
      expect(comp.childrenSharedCollection).toEqual(expectedCollection);
    });

    it('Should update editForm', () => {
      const alert: IAlert = { id: 17171 };
      const child: IChild = { id: 19105 };
      alert.child = child;

      activatedRoute.data = of({ alert });
      comp.ngOnInit();

      expect(comp.childrenSharedCollection).toContainEqual(child);
      expect(comp.alert).toEqual(alert);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IAlert>>();
      const alert = { id: 22054 };
      jest.spyOn(alertFormService, 'getAlert').mockReturnValue(alert);
      jest.spyOn(alertService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ alert });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: alert }));
      saveSubject.complete();

      // THEN
      expect(alertFormService.getAlert).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(alertService.update).toHaveBeenCalledWith(expect.objectContaining(alert));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IAlert>>();
      const alert = { id: 22054 };
      jest.spyOn(alertFormService, 'getAlert').mockReturnValue({ id: null });
      jest.spyOn(alertService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ alert: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: alert }));
      saveSubject.complete();

      // THEN
      expect(alertFormService.getAlert).toHaveBeenCalled();
      expect(alertService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IAlert>>();
      const alert = { id: 22054 };
      jest.spyOn(alertService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ alert });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(alertService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });

  describe('Compare relationships', () => {
    describe('compareChild', () => {
      it('Should forward to childService', () => {
        const entity = { id: 19105 };
        const entity2 = { id: 5932 };
        jest.spyOn(childService, 'compareChild');
        comp.compareChild(entity, entity2);
        expect(childService.compareChild).toHaveBeenCalledWith(entity, entity2);
      });
    });
  });
});
