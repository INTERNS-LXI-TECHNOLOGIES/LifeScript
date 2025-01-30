import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { ITongueTwister } from '../tongue-twister.model';
import { TongueTwisterService } from '../service/tongue-twister.service';

@Component({
  standalone: true,
  templateUrl: './tongue-twister-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class TongueTwisterDeleteDialogComponent {
  tongueTwister?: ITongueTwister;

  protected tongueTwisterService = inject(TongueTwisterService);
  protected activeModal = inject(NgbActiveModal);

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.tongueTwisterService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
