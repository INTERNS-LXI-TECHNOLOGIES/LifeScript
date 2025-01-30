import { Component, input } from '@angular/core';
import { RouterModule } from '@angular/router';

import SharedModule from 'app/shared/shared.module';
import { ITwisterPractice } from '../twister-practice.model';

@Component({
  selector: 'jhi-twister-practice-detail',
  templateUrl: './twister-practice-detail.component.html',
  imports: [SharedModule, RouterModule],
})
export class TwisterPracticeDetailComponent {
  twisterPractice = input<ITwisterPractice | null>(null);

  previousState(): void {
    window.history.back();
  }
}
