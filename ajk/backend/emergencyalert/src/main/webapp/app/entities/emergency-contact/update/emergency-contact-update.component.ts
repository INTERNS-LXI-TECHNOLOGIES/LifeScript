import { Component, OnInit, inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize, map } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IParent } from 'app/entities/parent/parent.model';
import { ParentService } from 'app/entities/parent/service/parent.service';
import { IEmergencyContact } from '../emergency-contact.model';
import { EmergencyContactService } from '../service/emergency-contact.service';
import { EmergencyContactFormGroup, EmergencyContactFormService } from './emergency-contact-form.service';

@Component({
  selector: 'jhi-emergency-contact-update',
  templateUrl: './emergency-contact-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class EmergencyContactUpdateComponent implements OnInit {
  isSaving = false;
  emergencyContact: IEmergencyContact | null = null;

  parentsSharedCollection: IParent[] = [];

  protected emergencyContactService = inject(EmergencyContactService);
  protected emergencyContactFormService = inject(EmergencyContactFormService);
  protected parentService = inject(ParentService);
  protected activatedRoute = inject(ActivatedRoute);

  // eslint-disable-next-line @typescript-eslint/member-ordering
  editForm: EmergencyContactFormGroup = this.emergencyContactFormService.createEmergencyContactFormGroup();

  compareParent = (o1: IParent | null, o2: IParent | null): boolean => this.parentService.compareParent(o1, o2);

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ emergencyContact }) => {
      this.emergencyContact = emergencyContact;
      if (emergencyContact) {
        this.updateForm(emergencyContact);
      }

      this.loadRelationshipsOptions();
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const emergencyContact = this.emergencyContactFormService.getEmergencyContact(this.editForm);
    if (emergencyContact.id !== null) {
      this.subscribeToSaveResponse(this.emergencyContactService.update(emergencyContact));
    } else {
      this.subscribeToSaveResponse(this.emergencyContactService.create(emergencyContact));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IEmergencyContact>>): void {
    result.pipe(finalize(() => this.onSaveFinalize())).subscribe({
      next: () => this.onSaveSuccess(),
      error: () => this.onSaveError(),
    });
  }

  protected onSaveSuccess(): void {
    this.previousState();
  }

  protected onSaveError(): void {
    // Api for inheritance.
  }

  protected onSaveFinalize(): void {
    this.isSaving = false;
  }

  protected updateForm(emergencyContact: IEmergencyContact): void {
    this.emergencyContact = emergencyContact;
    this.emergencyContactFormService.resetForm(this.editForm, emergencyContact);

    this.parentsSharedCollection = this.parentService.addParentToCollectionIfMissing<IParent>(
      this.parentsSharedCollection,
      emergencyContact.parent,
    );
  }

  protected loadRelationshipsOptions(): void {
    this.parentService
      .query()
      .pipe(map((res: HttpResponse<IParent[]>) => res.body ?? []))
      .pipe(map((parents: IParent[]) => this.parentService.addParentToCollectionIfMissing<IParent>(parents, this.emergencyContact?.parent)))
      .subscribe((parents: IParent[]) => (this.parentsSharedCollection = parents));
  }
}
