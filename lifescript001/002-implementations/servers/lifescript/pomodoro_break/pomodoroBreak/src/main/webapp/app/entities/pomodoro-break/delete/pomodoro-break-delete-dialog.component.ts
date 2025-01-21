import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IPomodoroBreak } from '../pomodoro-break.model';
import { PomodoroBreakService } from '../service/pomodoro-break.service';

@Component({
  templateUrl: './pomodoro-break-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class PomodoroBreakDeleteDialogComponent {
  pomodoroBreak?: IPomodoroBreak;

  protected pomodoroBreakService = inject(PomodoroBreakService);
  protected activeModal = inject(NgbActiveModal);

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.pomodoroBreakService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
