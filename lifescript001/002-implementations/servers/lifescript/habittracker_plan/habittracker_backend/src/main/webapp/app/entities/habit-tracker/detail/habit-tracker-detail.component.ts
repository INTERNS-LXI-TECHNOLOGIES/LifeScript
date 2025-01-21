import { Component, input } from '@angular/core';
import { RouterModule } from '@angular/router';

import SharedModule from 'app/shared/shared.module';
import { IHabitTracker } from '../habit-tracker.model';

@Component({
  selector: 'jhi-habit-tracker-detail',
  templateUrl: './habit-tracker-detail.component.html',
  imports: [SharedModule, RouterModule],
})
export class HabitTrackerDetailComponent {
  habitTracker = input<IHabitTracker | null>(null);

  previousState(): void {
    window.history.back();
  }
}
