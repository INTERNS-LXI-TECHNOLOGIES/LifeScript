import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpHeaders, HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of } from 'rxjs';

import { DailyJournalService } from '../service/daily-journal.service';

import { DailyJournalComponent } from './daily-journal.component';

describe('DailyJournal Management Component', () => {
  let comp: DailyJournalComponent;
  let fixture: ComponentFixture<DailyJournalComponent>;
  let service: DailyJournalService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [
        RouterTestingModule.withRoutes([{ path: 'daily-journal', component: DailyJournalComponent }]),
        HttpClientTestingModule,
        DailyJournalComponent,
      ],
      providers: [
        {
          provide: ActivatedRoute,
          useValue: {
            data: of({
              defaultSort: 'id,asc',
            }),
            queryParamMap: of(
              jest.requireActual('@angular/router').convertToParamMap({
                page: '1',
                size: '1',
                sort: 'id,desc',
              }),
            ),
            snapshot: { queryParams: {} },
          },
        },
      ],
    })
      .overrideTemplate(DailyJournalComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(DailyJournalComponent);
    comp = fixture.componentInstance;
    service = TestBed.inject(DailyJournalService);

    const headers = new HttpHeaders();
    jest.spyOn(service, 'query').mockReturnValue(
      of(
        new HttpResponse({
          body: [{ id: 123 }],
          headers,
        }),
      ),
    );
  });

  it('Should call load all on init', () => {
    // WHEN
    comp.ngOnInit();

    // THEN
    expect(service.query).toHaveBeenCalled();
    expect(comp.dailyJournals?.[0]).toEqual(expect.objectContaining({ id: 123 }));
  });

  describe('trackId', () => {
    it('Should forward to dailyJournalService', () => {
      const entity = { id: 123 };
      jest.spyOn(service, 'getDailyJournalIdentifier');
      const id = comp.trackId(0, entity);
      expect(service.getDailyJournalIdentifier).toHaveBeenCalledWith(entity);
      expect(id).toBe(entity.id);
    });
  });
});
