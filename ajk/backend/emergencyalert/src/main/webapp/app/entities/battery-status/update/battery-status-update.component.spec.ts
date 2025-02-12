import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { BatteryStatusService } from '../service/battery-status.service';
import { IBatteryStatus } from '../battery-status.model';
import { BatteryStatusFormService } from './battery-status-form.service';

import { BatteryStatusUpdateComponent } from './battery-status-update.component';

describe('BatteryStatus Management Update Component', () => {
  let comp: BatteryStatusUpdateComponent;
  let fixture: ComponentFixture<BatteryStatusUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let batteryStatusFormService: BatteryStatusFormService;
  let batteryStatusService: BatteryStatusService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [BatteryStatusUpdateComponent],
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
      .overrideTemplate(BatteryStatusUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(BatteryStatusUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    batteryStatusFormService = TestBed.inject(BatteryStatusFormService);
    batteryStatusService = TestBed.inject(BatteryStatusService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const batteryStatus: IBatteryStatus = { id: 22124 };

      activatedRoute.data = of({ batteryStatus });
      comp.ngOnInit();

      expect(comp.batteryStatus).toEqual(batteryStatus);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IBatteryStatus>>();
      const batteryStatus = { id: 20924 };
      jest.spyOn(batteryStatusFormService, 'getBatteryStatus').mockReturnValue(batteryStatus);
      jest.spyOn(batteryStatusService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ batteryStatus });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: batteryStatus }));
      saveSubject.complete();

      // THEN
      expect(batteryStatusFormService.getBatteryStatus).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(batteryStatusService.update).toHaveBeenCalledWith(expect.objectContaining(batteryStatus));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IBatteryStatus>>();
      const batteryStatus = { id: 20924 };
      jest.spyOn(batteryStatusFormService, 'getBatteryStatus').mockReturnValue({ id: null });
      jest.spyOn(batteryStatusService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ batteryStatus: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: batteryStatus }));
      saveSubject.complete();

      // THEN
      expect(batteryStatusFormService.getBatteryStatus).toHaveBeenCalled();
      expect(batteryStatusService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IBatteryStatus>>();
      const batteryStatus = { id: 20924 };
      jest.spyOn(batteryStatusService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ batteryStatus });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(batteryStatusService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
