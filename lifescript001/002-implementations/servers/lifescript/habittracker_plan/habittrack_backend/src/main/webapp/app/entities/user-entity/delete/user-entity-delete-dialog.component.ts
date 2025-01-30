import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IUserEntity } from '../user-entity.model';
import { UserEntityService } from '../service/user-entity.service';

@Component({
  templateUrl: './user-entity-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class UserEntityDeleteDialogComponent {
  userEntity?: IUserEntity;

  protected userEntityService = inject(UserEntityService);
  protected activeModal = inject(NgbActiveModal);

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.userEntityService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
