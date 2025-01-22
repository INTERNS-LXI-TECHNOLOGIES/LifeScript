import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { DemoService } from '../service/demo.service';
import { IDemo } from '../demo.model';
import { DemoFormService } from './demo-form.service';

import { DemoUpdateComponent } from './demo-update.component';

describe('Demo Management Update Component', () => {
  let comp: DemoUpdateComponent;
  let fixture: ComponentFixture<DemoUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let demoFormService: DemoFormService;
  let demoService: DemoService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [DemoUpdateComponent],
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
      .overrideTemplate(DemoUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(DemoUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    demoFormService = TestBed.inject(DemoFormService);
    demoService = TestBed.inject(DemoService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const demo: IDemo = { id: 32133 };

      activatedRoute.data = of({ demo });
      comp.ngOnInit();

      expect(comp.demo).toEqual(demo);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IDemo>>();
      const demo = { id: 29057 };
      jest.spyOn(demoFormService, 'getDemo').mockReturnValue(demo);
      jest.spyOn(demoService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ demo });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: demo }));
      saveSubject.complete();

      // THEN
      expect(demoFormService.getDemo).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(demoService.update).toHaveBeenCalledWith(expect.objectContaining(demo));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IDemo>>();
      const demo = { id: 29057 };
      jest.spyOn(demoFormService, 'getDemo').mockReturnValue({ id: null });
      jest.spyOn(demoService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ demo: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: demo }));
      saveSubject.complete();

      // THEN
      expect(demoFormService.getDemo).toHaveBeenCalled();
      expect(demoService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IDemo>>();
      const demo = { id: 29057 };
      jest.spyOn(demoService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ demo });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(demoService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
