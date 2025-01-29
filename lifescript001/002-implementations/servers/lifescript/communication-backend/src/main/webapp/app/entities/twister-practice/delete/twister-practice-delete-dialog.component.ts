import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { ITwisterPractice } from '../twister-practice.model';
import { TwisterPracticeService } from '../service/twister-practice.service';

@Component({
  templateUrl: './twister-practice-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class TwisterPracticeDeleteDialogComponent {
  twisterPractice?: ITwisterPractice;

  protected twisterPracticeService = inject(TwisterPracticeService);
  protected activeModal = inject(NgbActiveModal);

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.twisterPracticeService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
