import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { IGeoFence } from 'app/entities/geo-fence/geo-fence.model';
import { GeoFenceService } from 'app/entities/geo-fence/service/geo-fence.service';
import { IBatteryStatus } from 'app/entities/battery-status/battery-status.model';
import { BatteryStatusService } from 'app/entities/battery-status/service/battery-status.service';
import { ITeacher } from 'app/entities/teacher/teacher.model';
import { TeacherService } from 'app/entities/teacher/service/teacher.service';
import { IParent } from 'app/entities/parent/parent.model';
import { ParentService } from 'app/entities/parent/service/parent.service';
import { IChild } from '../child.model';
import { ChildService } from '../service/child.service';
import { ChildFormService } from './child-form.service';

import { ChildUpdateComponent } from './child-update.component';

describe('Child Management Update Component', () => {
  let comp: ChildUpdateComponent;
  let fixture: ComponentFixture<ChildUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let childFormService: ChildFormService;
  let childService: ChildService;
  let geoFenceService: GeoFenceService;
  let batteryStatusService: BatteryStatusService;
  let teacherService: TeacherService;
  let parentService: ParentService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [ChildUpdateComponent],
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
      .overrideTemplate(ChildUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(ChildUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    childFormService = TestBed.inject(ChildFormService);
    childService = TestBed.inject(ChildService);
    geoFenceService = TestBed.inject(GeoFenceService);
    batteryStatusService = TestBed.inject(BatteryStatusService);
    teacherService = TestBed.inject(TeacherService);
    parentService = TestBed.inject(ParentService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should call geoFence query and add missing value', () => {
      const child: IChild = { id: 5932 };
      const geoFence: IGeoFence = { id: 14261 };
      child.geoFence = geoFence;

      const geoFenceCollection: IGeoFence[] = [{ id: 14261 }];
      jest.spyOn(geoFenceService, 'query').mockReturnValue(of(new HttpResponse({ body: geoFenceCollection })));
      const expectedCollection: IGeoFence[] = [geoFence, ...geoFenceCollection];
      jest.spyOn(geoFenceService, 'addGeoFenceToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ child });
      comp.ngOnInit();

      expect(geoFenceService.query).toHaveBeenCalled();
      expect(geoFenceService.addGeoFenceToCollectionIfMissing).toHaveBeenCalledWith(geoFenceCollection, geoFence);
      expect(comp.geoFencesCollection).toEqual(expectedCollection);
    });

    it('Should call batteryStatus query and add missing value', () => {
      const child: IChild = { id: 5932 };
      const batteryStatus: IBatteryStatus = { id: 20924 };
      child.batteryStatus = batteryStatus;

      const batteryStatusCollection: IBatteryStatus[] = [{ id: 20924 }];
      jest.spyOn(batteryStatusService, 'query').mockReturnValue(of(new HttpResponse({ body: batteryStatusCollection })));
      const expectedCollection: IBatteryStatus[] = [batteryStatus, ...batteryStatusCollection];
      jest.spyOn(batteryStatusService, 'addBatteryStatusToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ child });
      comp.ngOnInit();

      expect(batteryStatusService.query).toHaveBeenCalled();
      expect(batteryStatusService.addBatteryStatusToCollectionIfMissing).toHaveBeenCalledWith(batteryStatusCollection, batteryStatus);
      expect(comp.batteryStatusesCollection).toEqual(expectedCollection);
    });

    it('Should call Teacher query and add missing value', () => {
      const child: IChild = { id: 5932 };
      const teacher: ITeacher = { id: 11312 };
      child.teacher = teacher;

      const teacherCollection: ITeacher[] = [{ id: 11312 }];
      jest.spyOn(teacherService, 'query').mockReturnValue(of(new HttpResponse({ body: teacherCollection })));
      const additionalTeachers = [teacher];
      const expectedCollection: ITeacher[] = [...additionalTeachers, ...teacherCollection];
      jest.spyOn(teacherService, 'addTeacherToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ child });
      comp.ngOnInit();

      expect(teacherService.query).toHaveBeenCalled();
      expect(teacherService.addTeacherToCollectionIfMissing).toHaveBeenCalledWith(
        teacherCollection,
        ...additionalTeachers.map(expect.objectContaining),
      );
      expect(comp.teachersSharedCollection).toEqual(expectedCollection);
    });

    it('Should call Parent query and add missing value', () => {
      const child: IChild = { id: 5932 };
      const parent: IParent = { id: 10134 };
      child.parent = parent;

      const parentCollection: IParent[] = [{ id: 10134 }];
      jest.spyOn(parentService, 'query').mockReturnValue(of(new HttpResponse({ body: parentCollection })));
      const additionalParents = [parent];
      const expectedCollection: IParent[] = [...additionalParents, ...parentCollection];
      jest.spyOn(parentService, 'addParentToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ child });
      comp.ngOnInit();

      expect(parentService.query).toHaveBeenCalled();
      expect(parentService.addParentToCollectionIfMissing).toHaveBeenCalledWith(
        parentCollection,
        ...additionalParents.map(expect.objectContaining),
      );
      expect(comp.parentsSharedCollection).toEqual(expectedCollection);
    });

    it('Should update editForm', () => {
      const child: IChild = { id: 5932 };
      const geoFence: IGeoFence = { id: 14261 };
      child.geoFence = geoFence;
      const batteryStatus: IBatteryStatus = { id: 20924 };
      child.batteryStatus = batteryStatus;
      const teacher: ITeacher = { id: 11312 };
      child.teacher = teacher;
      const parent: IParent = { id: 10134 };
      child.parent = parent;

      activatedRoute.data = of({ child });
      comp.ngOnInit();

      expect(comp.geoFencesCollection).toContainEqual(geoFence);
      expect(comp.batteryStatusesCollection).toContainEqual(batteryStatus);
      expect(comp.teachersSharedCollection).toContainEqual(teacher);
      expect(comp.parentsSharedCollection).toContainEqual(parent);
      expect(comp.child).toEqual(child);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IChild>>();
      const child = { id: 19105 };
      jest.spyOn(childFormService, 'getChild').mockReturnValue(child);
      jest.spyOn(childService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ child });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: child }));
      saveSubject.complete();

      // THEN
      expect(childFormService.getChild).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(childService.update).toHaveBeenCalledWith(expect.objectContaining(child));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IChild>>();
      const child = { id: 19105 };
      jest.spyOn(childFormService, 'getChild').mockReturnValue({ id: null });
      jest.spyOn(childService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ child: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: child }));
      saveSubject.complete();

      // THEN
      expect(childFormService.getChild).toHaveBeenCalled();
      expect(childService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IChild>>();
      const child = { id: 19105 };
      jest.spyOn(childService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ child });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(childService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });

  describe('Compare relationships', () => {
    describe('compareGeoFence', () => {
      it('Should forward to geoFenceService', () => {
        const entity = { id: 14261 };
        const entity2 = { id: 22663 };
        jest.spyOn(geoFenceService, 'compareGeoFence');
        comp.compareGeoFence(entity, entity2);
        expect(geoFenceService.compareGeoFence).toHaveBeenCalledWith(entity, entity2);
      });
    });

    describe('compareBatteryStatus', () => {
      it('Should forward to batteryStatusService', () => {
        const entity = { id: 20924 };
        const entity2 = { id: 22124 };
        jest.spyOn(batteryStatusService, 'compareBatteryStatus');
        comp.compareBatteryStatus(entity, entity2);
        expect(batteryStatusService.compareBatteryStatus).toHaveBeenCalledWith(entity, entity2);
      });
    });

    describe('compareTeacher', () => {
      it('Should forward to teacherService', () => {
        const entity = { id: 11312 };
        const entity2 = { id: 13207 };
        jest.spyOn(teacherService, 'compareTeacher');
        comp.compareTeacher(entity, entity2);
        expect(teacherService.compareTeacher).toHaveBeenCalledWith(entity, entity2);
      });
    });

    describe('compareParent', () => {
      it('Should forward to parentService', () => {
        const entity = { id: 10134 };
        const entity2 = { id: 2353 };
        jest.spyOn(parentService, 'compareParent');
        comp.compareParent(entity, entity2);
        expect(parentService.compareParent).toHaveBeenCalledWith(entity, entity2);
      });
    });
  });
});
