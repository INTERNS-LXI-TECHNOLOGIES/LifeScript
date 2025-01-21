import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness } from '@angular/router/testing';
import { of } from 'rxjs';

import { PerfectDayDetailComponent } from './perfect-day-detail.component';

describe('PerfectDay Management Detail Component', () => {
  let comp: PerfectDayDetailComponent;
  let fixture: ComponentFixture<PerfectDayDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PerfectDayDetailComponent],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              loadComponent: () => import('./perfect-day-detail.component').then(m => m.PerfectDayDetailComponent),
              resolve: { perfectDay: () => of({ id: 28965 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(PerfectDayDetailComponent, '')
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PerfectDayDetailComponent);
    comp = fixture.componentInstance;
  });

  describe('OnInit', () => {
    it('Should load perfectDay on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', PerfectDayDetailComponent);

      // THEN
      expect(instance.perfectDay()).toEqual(expect.objectContaining({ id: 28965 }));
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
