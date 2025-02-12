import { Component, input } from '@angular/core';
import { RouterModule } from '@angular/router';

import SharedModule from 'app/shared/shared.module';
import { IGeoFence } from '../geo-fence.model';

@Component({
  selector: 'jhi-geo-fence-detail',
  templateUrl: './geo-fence-detail.component.html',
  imports: [SharedModule, RouterModule],
})
export class GeoFenceDetailComponent {
  geoFence = input<IGeoFence | null>(null);

  previousState(): void {
    window.history.back();
  }
}
