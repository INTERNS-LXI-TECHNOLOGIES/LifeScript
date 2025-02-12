import { Component, input } from '@angular/core';
import { RouterModule } from '@angular/router';

import SharedModule from 'app/shared/shared.module';
import { IEmergencyContact } from '../emergency-contact.model';

@Component({
  selector: 'jhi-emergency-contact-detail',
  templateUrl: './emergency-contact-detail.component.html',
  imports: [SharedModule, RouterModule],
})
export class EmergencyContactDetailComponent {
  emergencyContact = input<IEmergencyContact | null>(null);

  previousState(): void {
    window.history.back();
  }
}
