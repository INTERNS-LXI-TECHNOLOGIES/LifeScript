import { Component, input } from '@angular/core';
import { RouterModule } from '@angular/router';

import SharedModule from 'app/shared/shared.module';
import { FormatMediumDatetimePipe } from 'app/shared/date';
import { IPomodoroBreak } from '../pomodoro-break.model';

@Component({
  selector: 'jhi-pomodoro-break-detail',
  templateUrl: './pomodoro-break-detail.component.html',
  imports: [SharedModule, RouterModule, FormatMediumDatetimePipe],
})
export class PomodoroBreakDetailComponent {
  pomodoroBreak = input<IPomodoroBreak | null>(null);

  previousState(): void {
    window.history.back();
  }
}
