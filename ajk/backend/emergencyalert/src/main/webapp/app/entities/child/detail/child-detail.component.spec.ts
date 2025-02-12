import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness } from '@angular/router/testing';
import { of } from 'rxjs';

import { ChildDetailComponent } from './child-detail.component';

describe('Child Management Detail Component', () => {
  let comp: ChildDetailComponent;
  let fixture: ComponentFixture<ChildDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ChildDetailComponent],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              loadComponent: () => import('./child-detail.component').then(m => m.ChildDetailComponent),
              resolve: { child: () => of({ id: 19105 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(ChildDetailComponent, '')
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ChildDetailComponent);
    comp = fixture.componentInstance;
  });

  describe('OnInit', () => {
    it('Should load child on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', ChildDetailComponent);

      // THEN
      expect(instance.child()).toEqual(expect.objectContaining({ id: 19105 }));
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
