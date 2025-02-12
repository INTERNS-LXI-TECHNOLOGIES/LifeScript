import { Component, input } from '@angular/core';
import { RouterModule } from '@angular/router';

import SharedModule from 'app/shared/shared.module';
import { IChild } from '../child.model';

@Component({
  selector: 'jhi-child-detail',
  templateUrl: './child-detail.component.html',
  imports: [SharedModule, RouterModule],
})
export class ChildDetailComponent {
  child = input<IChild | null>(null);

  previousState(): void {
    window.history.back();
  }
}
