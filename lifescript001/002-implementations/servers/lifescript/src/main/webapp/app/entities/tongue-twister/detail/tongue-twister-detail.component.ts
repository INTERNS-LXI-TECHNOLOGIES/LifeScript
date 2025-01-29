import { Component, input } from '@angular/core';
import { RouterModule } from '@angular/router';

import SharedModule from 'app/shared/shared.module';
import { DurationPipe, FormatMediumDatetimePipe, FormatMediumDatePipe } from 'app/shared/date';
import { ITongueTwister } from '../tongue-twister.model';

@Component({
  standalone: true,
  selector: 'jhi-tongue-twister-detail',
  templateUrl: './tongue-twister-detail.component.html',
  imports: [SharedModule, RouterModule, DurationPipe, FormatMediumDatetimePipe, FormatMediumDatePipe],
})
export class TongueTwisterDetailComponent {
  tongueTwister = input<ITongueTwister | null>(null);

  previousState(): void {
    window.history.back();
  }
}
