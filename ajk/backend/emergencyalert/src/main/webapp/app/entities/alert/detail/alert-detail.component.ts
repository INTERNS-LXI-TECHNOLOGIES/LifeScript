import { Component, input } from '@angular/core';
import { RouterModule } from '@angular/router';

import SharedModule from 'app/shared/shared.module';
import { FormatMediumDatetimePipe } from 'app/shared/date';
import { IAlert } from '../alert.model';

@Component({
  selector: 'jhi-alert-detail',
  templateUrl: './alert-detail.component.html',
  imports: [SharedModule, RouterModule, FormatMediumDatetimePipe],
})
export class AlertDetailComponent {
  alert = input<IAlert | null>(null);

  previousState(): void {
    window.history.back();
  }
}
