import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { UserEntityService } from '../service/user-entity.service';
import { IUserEntity } from '../user-entity.model';
import { UserEntityFormService } from './user-entity-form.service';

import { UserEntityUpdateComponent } from './user-entity-update.component';

describe('UserEntity Management Update Component', () => {
  let comp: UserEntityUpdateComponent;
  let fixture: ComponentFixture<UserEntityUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let userEntityFormService: UserEntityFormService;
  let userEntityService: UserEntityService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [UserEntityUpdateComponent],
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
      .overrideTemplate(UserEntityUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(UserEntityUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    userEntityFormService = TestBed.inject(UserEntityFormService);
    userEntityService = TestBed.inject(UserEntityService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const userEntity: IUserEntity = { id: 25078 };

      activatedRoute.data = of({ userEntity });
      comp.ngOnInit();

      expect(comp.userEntity).toEqual(userEntity);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IUserEntity>>();
      const userEntity = { id: 27146 };
      jest.spyOn(userEntityFormService, 'getUserEntity').mockReturnValue(userEntity);
      jest.spyOn(userEntityService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ userEntity });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: userEntity }));
      saveSubject.complete();

      // THEN
      expect(userEntityFormService.getUserEntity).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(userEntityService.update).toHaveBeenCalledWith(expect.objectContaining(userEntity));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IUserEntity>>();
      const userEntity = { id: 27146 };
      jest.spyOn(userEntityFormService, 'getUserEntity').mockReturnValue({ id: null });
      jest.spyOn(userEntityService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ userEntity: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: userEntity }));
      saveSubject.complete();

      // THEN
      expect(userEntityFormService.getUserEntity).toHaveBeenCalled();
      expect(userEntityService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IUserEntity>>();
      const userEntity = { id: 27146 };
      jest.spyOn(userEntityService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ userEntity });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(userEntityService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
