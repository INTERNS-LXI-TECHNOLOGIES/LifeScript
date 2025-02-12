import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness } from '@angular/router/testing';
import { of } from 'rxjs';

import { BatteryStatusDetailComponent } from './battery-status-detail.component';

describe('BatteryStatus Management Detail Component', () => {
  let comp: BatteryStatusDetailComponent;
  let fixture: ComponentFixture<BatteryStatusDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [BatteryStatusDetailComponent],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              loadComponent: () => import('./battery-status-detail.component').then(m => m.BatteryStatusDetailComponent),
              resolve: { batteryStatus: () => of({ id: 20924 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(BatteryStatusDetailComponent, '')
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BatteryStatusDetailComponent);
    comp = fixture.componentInstance;
  });

  describe('OnInit', () => {
    it('Should load batteryStatus on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', BatteryStatusDetailComponent);

      // THEN
      expect(instance.batteryStatus()).toEqual(expect.objectContaining({ id: 20924 }));
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
