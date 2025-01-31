import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness } from '@angular/router/testing';
import { of } from 'rxjs';

import { TongueTwisterDetailComponent } from './tongue-twister-detail.component';

describe('TongueTwister Management Detail Component', () => {
  let comp: TongueTwisterDetailComponent;
  let fixture: ComponentFixture<TongueTwisterDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TongueTwisterDetailComponent],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              component: TongueTwisterDetailComponent,
              resolve: { tongueTwister: () => of({ id: 123 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(TongueTwisterDetailComponent, '')
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(TongueTwisterDetailComponent);
    comp = fixture.componentInstance;
  });

  describe('OnInit', () => {
    it('Should load tongueTwister on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', TongueTwisterDetailComponent);

      // THEN
      expect(instance.tongueTwister()).toEqual(expect.objectContaining({ id: 123 }));
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
