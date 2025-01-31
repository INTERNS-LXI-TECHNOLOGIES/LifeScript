import { Component, input } from '@angular/core';
import { RouterModule } from '@angular/router';

import SharedModule from 'app/shared/shared.module';
import { IHabitTrack } from '../habit-track.model';

@Component({
  selector: 'jhi-habit-track-detail',
  templateUrl: './habit-track-detail.component.html',
  imports: [SharedModule, RouterModule],
})
export class HabitTrackDetailComponent {
  habitTrack = input<IHabitTrack | null>(null);

  previousState(): void {
    window.history.back();
  }
}
