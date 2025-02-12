import { Component, input } from '@angular/core';
import { RouterModule } from '@angular/router';

import SharedModule from 'app/shared/shared.module';
import { IBatteryStatus } from '../battery-status.model';

@Component({
  selector: 'jhi-battery-status-detail',
  templateUrl: './battery-status-detail.component.html',
  imports: [SharedModule, RouterModule],
})
export class BatteryStatusDetailComponent {
  batteryStatus = input<IBatteryStatus | null>(null);

  previousState(): void {
    window.history.back();
  }
}
