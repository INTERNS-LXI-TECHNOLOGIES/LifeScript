import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IDemo } from '../demo.model';
import { DemoService } from '../service/demo.service';

@Component({
  templateUrl: './demo-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class DemoDeleteDialogComponent {
  demo?: IDemo;

  protected demoService = inject(DemoService);
  protected activeModal = inject(NgbActiveModal);

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.demoService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
