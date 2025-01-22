import { Component, input } from '@angular/core';
import { RouterModule } from '@angular/router';

import SharedModule from 'app/shared/shared.module';
import { IDemo } from '../demo.model';

@Component({
  selector: 'jhi-demo-detail',
  templateUrl: './demo-detail.component.html',
  imports: [SharedModule, RouterModule],
})
export class DemoDetailComponent {
  demo = input<IDemo | null>(null);

  previousState(): void {
    window.history.back();
  }
}
