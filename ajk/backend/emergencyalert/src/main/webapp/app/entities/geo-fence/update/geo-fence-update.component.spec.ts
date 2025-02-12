import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { GeoFenceService } from '../service/geo-fence.service';
import { IGeoFence } from '../geo-fence.model';
import { GeoFenceFormService } from './geo-fence-form.service';

import { GeoFenceUpdateComponent } from './geo-fence-update.component';

describe('GeoFence Management Update Component', () => {
  let comp: GeoFenceUpdateComponent;
  let fixture: ComponentFixture<GeoFenceUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let geoFenceFormService: GeoFenceFormService;
  let geoFenceService: GeoFenceService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [GeoFenceUpdateComponent],
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
      .overrideTemplate(GeoFenceUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(GeoFenceUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    geoFenceFormService = TestBed.inject(GeoFenceFormService);
    geoFenceService = TestBed.inject(GeoFenceService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const geoFence: IGeoFence = { id: 22663 };

      activatedRoute.data = of({ geoFence });
      comp.ngOnInit();

      expect(comp.geoFence).toEqual(geoFence);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IGeoFence>>();
      const geoFence = { id: 14261 };
      jest.spyOn(geoFenceFormService, 'getGeoFence').mockReturnValue(geoFence);
      jest.spyOn(geoFenceService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ geoFence });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: geoFence }));
      saveSubject.complete();

      // THEN
      expect(geoFenceFormService.getGeoFence).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(geoFenceService.update).toHaveBeenCalledWith(expect.objectContaining(geoFence));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IGeoFence>>();
      const geoFence = { id: 14261 };
      jest.spyOn(geoFenceFormService, 'getGeoFence').mockReturnValue({ id: null });
      jest.spyOn(geoFenceService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ geoFence: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: geoFence }));
      saveSubject.complete();

      // THEN
      expect(geoFenceFormService.getGeoFence).toHaveBeenCalled();
      expect(geoFenceService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IGeoFence>>();
      const geoFence = { id: 14261 };
      jest.spyOn(geoFenceService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ geoFence });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(geoFenceService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
