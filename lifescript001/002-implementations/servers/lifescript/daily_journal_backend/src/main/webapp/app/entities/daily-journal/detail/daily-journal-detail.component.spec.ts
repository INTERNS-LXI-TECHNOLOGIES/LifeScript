import { TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness, RouterTestingModule } from '@angular/router/testing';
import { of } from 'rxjs';

import { DailyJournalDetailComponent } from './daily-journal-detail.component';

describe('DailyJournal Management Detail Component', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DailyJournalDetailComponent, RouterTestingModule.withRoutes([], { bindToComponentInputs: true })],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              component: DailyJournalDetailComponent,
              resolve: { dailyJournal: () => of({ id: 123 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(DailyJournalDetailComponent, '')
      .compileComponents();
  });

  describe('OnInit', () => {
    it('Should load dailyJournal on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', DailyJournalDetailComponent);

      // THEN
      expect(instance.dailyJournal).toEqual(expect.objectContaining({ id: 123 }));
    });
  });
});
