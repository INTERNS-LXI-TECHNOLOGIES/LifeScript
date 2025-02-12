import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness } from '@angular/router/testing';
import { of } from 'rxjs';

import { EmergencyContactDetailComponent } from './emergency-contact-detail.component';

describe('EmergencyContact Management Detail Component', () => {
  let comp: EmergencyContactDetailComponent;
  let fixture: ComponentFixture<EmergencyContactDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [EmergencyContactDetailComponent],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              loadComponent: () => import('./emergency-contact-detail.component').then(m => m.EmergencyContactDetailComponent),
              resolve: { emergencyContact: () => of({ id: 32648 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(EmergencyContactDetailComponent, '')
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(EmergencyContactDetailComponent);
    comp = fixture.componentInstance;
  });

  describe('OnInit', () => {
    it('Should load emergencyContact on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', EmergencyContactDetailComponent);

      // THEN
      expect(instance.emergencyContact()).toEqual(expect.objectContaining({ id: 32648 }));
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
