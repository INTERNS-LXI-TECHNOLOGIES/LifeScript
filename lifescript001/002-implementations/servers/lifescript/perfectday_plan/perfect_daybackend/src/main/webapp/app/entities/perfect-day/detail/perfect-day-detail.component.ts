import { Component, input } from '@angular/core';
import { RouterModule } from '@angular/router';

import SharedModule from 'app/shared/shared.module';
import { FormatMediumDatePipe } from 'app/shared/date';
import { IPerfectDay } from '../perfect-day.model';

@Component({
  selector: 'jhi-perfect-day-detail',
  templateUrl: './perfect-day-detail.component.html',
  imports: [SharedModule, RouterModule, FormatMediumDatePipe],
})
export class PerfectDayDetailComponent {
  perfectDay = input<IPerfectDay | null>(null);

  previousState(): void {
    window.history.back();
  }
}
