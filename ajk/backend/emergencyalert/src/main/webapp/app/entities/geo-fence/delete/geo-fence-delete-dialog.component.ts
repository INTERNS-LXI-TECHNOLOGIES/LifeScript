import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IGeoFence } from '../geo-fence.model';
import { GeoFenceService } from '../service/geo-fence.service';

@Component({
  templateUrl: './geo-fence-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class GeoFenceDeleteDialogComponent {
  geoFence?: IGeoFence;

  protected geoFenceService = inject(GeoFenceService);
  protected activeModal = inject(NgbActiveModal);

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.geoFenceService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
