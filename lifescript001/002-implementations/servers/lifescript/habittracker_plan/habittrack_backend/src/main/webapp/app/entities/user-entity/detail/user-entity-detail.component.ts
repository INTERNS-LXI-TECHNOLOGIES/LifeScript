import { Component, input } from '@angular/core';
import { RouterModule } from '@angular/router';

import SharedModule from 'app/shared/shared.module';
import { IUserEntity } from '../user-entity.model';

@Component({
  selector: 'jhi-user-entity-detail',
  templateUrl: './user-entity-detail.component.html',
  imports: [SharedModule, RouterModule],
})
export class UserEntityDetailComponent {
  userEntity = input<IUserEntity | null>(null);

  previousState(): void {
    window.history.back();
  }
}
