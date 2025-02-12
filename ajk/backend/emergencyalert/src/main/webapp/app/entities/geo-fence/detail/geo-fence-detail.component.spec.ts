import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness } from '@angular/router/testing';
import { of } from 'rxjs';

import { GeoFenceDetailComponent } from './geo-fence-detail.component';

describe('GeoFence Management Detail Component', () => {
  let comp: GeoFenceDetailComponent;
  let fixture: ComponentFixture<GeoFenceDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [GeoFenceDetailComponent],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              loadComponent: () => import('./geo-fence-detail.component').then(m => m.GeoFenceDetailComponent),
              resolve: { geoFence: () => of({ id: 14261 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(GeoFenceDetailComponent, '')
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(GeoFenceDetailComponent);
    comp = fixture.componentInstance;
  });

  describe('OnInit', () => {
    it('Should load geoFence on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', GeoFenceDetailComponent);

      // THEN
      expect(instance.geoFence()).toEqual(expect.objectContaining({ id: 14261 }));
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
