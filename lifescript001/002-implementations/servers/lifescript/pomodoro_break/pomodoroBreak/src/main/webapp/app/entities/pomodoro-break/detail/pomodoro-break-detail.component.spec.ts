import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness } from '@angular/router/testing';
import { of } from 'rxjs';

import { PomodoroBreakDetailComponent } from './pomodoro-break-detail.component';

describe('PomodoroBreak Management Detail Component', () => {
  let comp: PomodoroBreakDetailComponent;
  let fixture: ComponentFixture<PomodoroBreakDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PomodoroBreakDetailComponent],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              loadComponent: () => import('./pomodoro-break-detail.component').then(m => m.PomodoroBreakDetailComponent),
              resolve: { pomodoroBreak: () => of({ id: 1428 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(PomodoroBreakDetailComponent, '')
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PomodoroBreakDetailComponent);
    comp = fixture.componentInstance;
  });

  describe('OnInit', () => {
    it('Should load pomodoroBreak on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', PomodoroBreakDetailComponent);

      // THEN
      expect(instance.pomodoroBreak()).toEqual(expect.objectContaining({ id: 1428 }));
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
