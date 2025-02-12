import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IChild } from '../child.model';
import { ChildService } from '../service/child.service';

@Component({
  templateUrl: './child-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class ChildDeleteDialogComponent {
  child?: IChild;

  protected childService = inject(ChildService);
  protected activeModal = inject(NgbActiveModal);

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.childService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
