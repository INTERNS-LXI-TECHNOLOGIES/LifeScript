import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IMediaContent } from '../media-content.model';
import { MediaContentService } from '../service/media-content.service';

@Component({
  templateUrl: './media-content-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class MediaContentDeleteDialogComponent {
  mediaContent?: IMediaContent;

  protected mediaContentService = inject(MediaContentService);
  protected activeModal = inject(NgbActiveModal);

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.mediaContentService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
