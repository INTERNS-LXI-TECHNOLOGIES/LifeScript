import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { IParent } from 'app/entities/parent/parent.model';
import { ParentService } from 'app/entities/parent/service/parent.service';
import { EmergencyContactService } from '../service/emergency-contact.service';
import { IEmergencyContact } from '../emergency-contact.model';
import { EmergencyContactFormService } from './emergency-contact-form.service';

import { EmergencyContactUpdateComponent } from './emergency-contact-update.component';

describe('EmergencyContact Management Update Component', () => {
  let comp: EmergencyContactUpdateComponent;
  let fixture: ComponentFixture<EmergencyContactUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let emergencyContactFormService: EmergencyContactFormService;
  let emergencyContactService: EmergencyContactService;
  let parentService: ParentService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [EmergencyContactUpdateComponent],
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
      .overrideTemplate(EmergencyContactUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(EmergencyContactUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    emergencyContactFormService = TestBed.inject(EmergencyContactFormService);
    emergencyContactService = TestBed.inject(EmergencyContactService);
    parentService = TestBed.inject(ParentService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should call Parent query and add missing value', () => {
      const emergencyContact: IEmergencyContact = { id: 16332 };
      const parent: IParent = { id: 10134 };
      emergencyContact.parent = parent;

      const parentCollection: IParent[] = [{ id: 10134 }];
      jest.spyOn(parentService, 'query').mockReturnValue(of(new HttpResponse({ body: parentCollection })));
      const additionalParents = [parent];
      const expectedCollection: IParent[] = [...additionalParents, ...parentCollection];
      jest.spyOn(parentService, 'addParentToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ emergencyContact });
      comp.ngOnInit();

      expect(parentService.query).toHaveBeenCalled();
      expect(parentService.addParentToCollectionIfMissing).toHaveBeenCalledWith(
        parentCollection,
        ...additionalParents.map(expect.objectContaining),
      );
      expect(comp.parentsSharedCollection).toEqual(expectedCollection);
    });

    it('Should update editForm', () => {
      const emergencyContact: IEmergencyContact = { id: 16332 };
      const parent: IParent = { id: 10134 };
      emergencyContact.parent = parent;

      activatedRoute.data = of({ emergencyContact });
      comp.ngOnInit();

      expect(comp.parentsSharedCollection).toContainEqual(parent);
      expect(comp.emergencyContact).toEqual(emergencyContact);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IEmergencyContact>>();
      const emergencyContact = { id: 32648 };
      jest.spyOn(emergencyContactFormService, 'getEmergencyContact').mockReturnValue(emergencyContact);
      jest.spyOn(emergencyContactService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ emergencyContact });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: emergencyContact }));
      saveSubject.complete();

      // THEN
      expect(emergencyContactFormService.getEmergencyContact).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(emergencyContactService.update).toHaveBeenCalledWith(expect.objectContaining(emergencyContact));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IEmergencyContact>>();
      const emergencyContact = { id: 32648 };
      jest.spyOn(emergencyContactFormService, 'getEmergencyContact').mockReturnValue({ id: null });
      jest.spyOn(emergencyContactService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ emergencyContact: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: emergencyContact }));
      saveSubject.complete();

      // THEN
      expect(emergencyContactFormService.getEmergencyContact).toHaveBeenCalled();
      expect(emergencyContactService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IEmergencyContact>>();
      const emergencyContact = { id: 32648 };
      jest.spyOn(emergencyContactService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ emergencyContact });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(emergencyContactService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });

  describe('Compare relationships', () => {
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
