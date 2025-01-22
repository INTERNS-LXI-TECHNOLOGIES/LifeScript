import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness } from '@angular/router/testing';
import { of } from 'rxjs';

import { DemoDetailComponent } from './demo-detail.component';

describe('Demo Management Detail Component', () => {
  let comp: DemoDetailComponent;
  let fixture: ComponentFixture<DemoDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DemoDetailComponent],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              loadComponent: () => import('./demo-detail.component').then(m => m.DemoDetailComponent),
              resolve: { demo: () => of({ id: 29057 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(DemoDetailComponent, '')
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DemoDetailComponent);
    comp = fixture.componentInstance;
  });

  describe('OnInit', () => {
    it('Should load demo on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', DemoDetailComponent);

      // THEN
      expect(instance.demo()).toEqual(expect.objectContaining({ id: 29057 }));
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
