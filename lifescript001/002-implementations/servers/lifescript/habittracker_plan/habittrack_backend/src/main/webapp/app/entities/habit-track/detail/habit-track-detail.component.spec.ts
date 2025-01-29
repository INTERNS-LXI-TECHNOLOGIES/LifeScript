import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness } from '@angular/router/testing';
import { of } from 'rxjs';

import { HabitTrackDetailComponent } from './habit-track-detail.component';

describe('HabitTrack Management Detail Component', () => {
  let comp: HabitTrackDetailComponent;
  let fixture: ComponentFixture<HabitTrackDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HabitTrackDetailComponent],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              loadComponent: () => import('./habit-track-detail.component').then(m => m.HabitTrackDetailComponent),
              resolve: { habitTrack: () => of({ id: 21546 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(HabitTrackDetailComponent, '')
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(HabitTrackDetailComponent);
    comp = fixture.componentInstance;
  });

  describe('OnInit', () => {
    it('Should load habitTrack on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', HabitTrackDetailComponent);

      // THEN
      expect(instance.habitTrack()).toEqual(expect.objectContaining({ id: 21546 }));
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
