import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness } from '@angular/router/testing';
import { of } from 'rxjs';

import { UserEntityDetailComponent } from './user-entity-detail.component';

describe('UserEntity Management Detail Component', () => {
  let comp: UserEntityDetailComponent;
  let fixture: ComponentFixture<UserEntityDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [UserEntityDetailComponent],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              loadComponent: () => import('./user-entity-detail.component').then(m => m.UserEntityDetailComponent),
              resolve: { userEntity: () => of({ id: 27146 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(UserEntityDetailComponent, '')
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(UserEntityDetailComponent);
    comp = fixture.componentInstance;
  });

  describe('OnInit', () => {
    it('Should load userEntity on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', UserEntityDetailComponent);

      // THEN
      expect(instance.userEntity()).toEqual(expect.objectContaining({ id: 27146 }));
    });
  });

  describe('PreviousState', () => {
    it('Should navigate to previous state', () => {
      jest.spyOn(window.history, 'back');
      comp.previousState();
      expect(window.history.back).toHaveBeenCalled();
    });
  });
});
