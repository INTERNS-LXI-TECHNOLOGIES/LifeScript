import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IHabitTrack } from '../habit-track.model';
import { HabitTrackService } from '../service/habit-track.service';

@Component({
  templateUrl: './habit-track-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class HabitTrackDeleteDialogComponent {
  habitTrack?: IHabitTrack;

  protected habitTrackService = inject(HabitTrackService);
  protected activeModal = inject(NgbActiveModal);

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.habitTrackService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
