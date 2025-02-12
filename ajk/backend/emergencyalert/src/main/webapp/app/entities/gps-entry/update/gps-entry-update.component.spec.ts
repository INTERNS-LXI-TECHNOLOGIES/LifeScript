import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { IChild } from 'app/entities/child/child.model';
import { ChildService } from 'app/entities/child/service/child.service';
import { GpsEntryService } from '../service/gps-entry.service';
import { IGpsEntry } from '../gps-entry.model';
import { GpsEntryFormService } from './gps-entry-form.service';

import { GpsEntryUpdateComponent } from './gps-entry-update.component';

describe('GpsEntry Management Update Component', () => {
  let comp: GpsEntryUpdateComponent;
  let fixture: ComponentFixture<GpsEntryUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let gpsEntryFormService: GpsEntryFormService;
  let gpsEntryService: GpsEntryService;
  let childService: ChildService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [GpsEntryUpdateComponent],
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
      .overrideTemplate(GpsEntryUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(GpsEntryUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    gpsEntryFormService = TestBed.inject(GpsEntryFormService);
    gpsEntryService = TestBed.inject(GpsEntryService);
    childService = TestBed.inject(ChildService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should call Child query and add missing value', () => {
      const gpsEntry: IGpsEntry = { id: 27363 };
      const child: IChild = { id: 19105 };
      gpsEntry.child = child;

      const childCollection: IChild[] = [{ id: 19105 }];
      jest.spyOn(childService, 'query').mockReturnValue(of(new HttpResponse({ body: childCollection })));
      const additionalChildren = [child];
      const expectedCollection: IChild[] = [...additionalChildren, ...childCollection];
      jest.spyOn(childService, 'addChildToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ gpsEntry });
      comp.ngOnInit();

      expect(childService.query).toHaveBeenCalled();
      expect(childService.addChildToCollectionIfMissing).toHaveBeenCalledWith(
        childCollection,
        ...additionalChildren.map(expect.objectContaining),
      );
      expect(comp.childrenSharedCollection).toEqual(expectedCollection);
    });

    it('Should update editForm', () => {
      const gpsEntry: IGpsEntry = { id: 27363 };
      const child: IChild = { id: 19105 };
      gpsEntry.child = child;

      activatedRoute.data = of({ gpsEntry });
      comp.ngOnInit();

      expect(comp.childrenSharedCollection).toContainEqual(child);
      expect(comp.gpsEntry).toEqual(gpsEntry);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IGpsEntry>>();
      const gpsEntry = { id: 18863 };
      jest.spyOn(gpsEntryFormService, 'getGpsEntry').mockReturnValue(gpsEntry);
      jest.spyOn(gpsEntryService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ gpsEntry });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: gpsEntry }));
      saveSubject.complete();

      // THEN
      expect(gpsEntryFormService.getGpsEntry).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(gpsEntryService.update).toHaveBeenCalledWith(expect.objectContaining(gpsEntry));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IGpsEntry>>();
      const gpsEntry = { id: 18863 };
      jest.spyOn(gpsEntryFormService, 'getGpsEntry').mockReturnValue({ id: null });
      jest.spyOn(gpsEntryService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ gpsEntry: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: gpsEntry }));
      saveSubject.complete();

      // THEN
      expect(gpsEntryFormService.getGpsEntry).toHaveBeenCalled();
      expect(gpsEntryService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IGpsEntry>>();
      const gpsEntry = { id: 18863 };
      jest.spyOn(gpsEntryService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ gpsEntry });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(gpsEntryService.update).toHaveBeenCalled();
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
