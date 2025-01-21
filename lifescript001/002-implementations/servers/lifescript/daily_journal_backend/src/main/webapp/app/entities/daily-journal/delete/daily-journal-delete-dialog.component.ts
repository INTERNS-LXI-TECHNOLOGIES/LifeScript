import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IDailyJournal } from '../daily-journal.model';
import { DailyJournalService } from '../service/daily-journal.service';

@Component({
  standalone: true,
  templateUrl: './daily-journal-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class DailyJournalDeleteDialogComponent {
  dailyJournal?: IDailyJournal;

  constructor(
    protected dailyJournalService: DailyJournalService,
    protected activeModal: NgbActiveModal,
  ) {}

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.dailyJournalService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
