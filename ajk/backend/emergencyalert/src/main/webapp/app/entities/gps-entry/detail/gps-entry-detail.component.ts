import { Component, input } from '@angular/core';
import { RouterModule } from '@angular/router';

import SharedModule from 'app/shared/shared.module';
import { FormatMediumDatetimePipe } from 'app/shared/date';
import { IGpsEntry } from '../gps-entry.model';

@Component({
  selector: 'jhi-gps-entry-detail',
  templateUrl: './gps-entry-detail.component.html',
  imports: [SharedModule, RouterModule, FormatMediumDatetimePipe],
})
export class GpsEntryDetailComponent {
  gpsEntry = input<IGpsEntry | null>(null);

  previousState(): void {
    window.history.back();
  }
}
