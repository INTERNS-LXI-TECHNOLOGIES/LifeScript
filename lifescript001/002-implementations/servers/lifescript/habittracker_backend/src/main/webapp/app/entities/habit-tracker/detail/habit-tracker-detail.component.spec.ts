import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness } from '@angular/router/testing';
import { of } from 'rxjs';

import { HabitTrackerDetailComponent } from './habit-tracker-detail.component';

describe('HabitTracker Management Detail Component', () => {
  let comp: HabitTrackerDetailComponent;
  let fixture: ComponentFixture<HabitTrackerDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HabitTrackerDetailComponent],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              loadComponent: () => import('./habit-tracker-detail.component').then(m => m.HabitTrackerDetailComponent),
              resolve: { habitTracker: () => of({ id: 10647 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(HabitTrackerDetailComponent, '')
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(HabitTrackerDetailComponent);
    comp = fixture.componentInstance;
  });

  describe('OnInit', () => {
    it('Should load habitTracker on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', HabitTrackerDetailComponent);

      // THEN
      expect(instance.habitTracker()).toEqual(expect.objectContaining({ id: 10647 }));
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
