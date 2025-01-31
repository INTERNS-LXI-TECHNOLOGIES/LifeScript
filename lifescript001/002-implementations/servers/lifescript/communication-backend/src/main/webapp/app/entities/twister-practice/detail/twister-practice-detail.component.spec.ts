import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness } from '@angular/router/testing';
import { of } from 'rxjs';

import { TwisterPracticeDetailComponent } from './twister-practice-detail.component';

describe('TwisterPractice Management Detail Component', () => {
  let comp: TwisterPracticeDetailComponent;
  let fixture: ComponentFixture<TwisterPracticeDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TwisterPracticeDetailComponent],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              loadComponent: () => import('./twister-practice-detail.component').then(m => m.TwisterPracticeDetailComponent),
              resolve: { twisterPractice: () => of({ id: 11105 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(TwisterPracticeDetailComponent, '')
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(TwisterPracticeDetailComponent);
    comp = fixture.componentInstance;
  });

  describe('OnInit', () => {
    it('Should load twisterPractice on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', TwisterPracticeDetailComponent);

      // THEN
      expect(instance.twisterPractice()).toEqual(expect.objectContaining({ id: 11105 }));
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
