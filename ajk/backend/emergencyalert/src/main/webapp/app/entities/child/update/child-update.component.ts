import { Component, OnInit, inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize, map } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IGeoFence } from 'app/entities/geo-fence/geo-fence.model';
import { GeoFenceService } from 'app/entities/geo-fence/service/geo-fence.service';
import { IBatteryStatus } from 'app/entities/battery-status/battery-status.model';
import { BatteryStatusService } from 'app/entities/battery-status/service/battery-status.service';
import { ITeacher } from 'app/entities/teacher/teacher.model';
import { TeacherService } from 'app/entities/teacher/service/teacher.service';
import { IParent } from 'app/entities/parent/parent.model';
import { ParentService } from 'app/entities/parent/service/parent.service';
import { ChildService } from '../service/child.service';
import { IChild } from '../child.model';
import { ChildFormGroup, ChildFormService } from './child-form.service';

@Component({
  selector: 'jhi-child-update',
  templateUrl: './child-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class ChildUpdateComponent implements OnInit {
  isSaving = false;
  child: IChild | null = null;

  geoFencesCollection: IGeoFence[] = [];
  batteryStatusesCollection: IBatteryStatus[] = [];
  teachersSharedCollection: ITeacher[] = [];
  parentsSharedCollection: IParent[] = [];

  protected childService = inject(ChildService);
  protected childFormService = inject(ChildFormService);
  protected geoFenceService = inject(GeoFenceService);
  protected batteryStatusService = inject(BatteryStatusService);
  protected teacherService = inject(TeacherService);
  protected parentService = inject(ParentService);
  protected activatedRoute = inject(ActivatedRoute);

  // eslint-disable-next-line @typescript-eslint/member-ordering
  editForm: ChildFormGroup = this.childFormService.createChildFormGroup();

  compareGeoFence = (o1: IGeoFence | null, o2: IGeoFence | null): boolean => this.geoFenceService.compareGeoFence(o1, o2);

  compareBatteryStatus = (o1: IBatteryStatus | null, o2: IBatteryStatus | null): boolean =>
    this.batteryStatusService.compareBatteryStatus(o1, o2);

  compareTeacher = (o1: ITeacher | null, o2: ITeacher | null): boolean => this.teacherService.compareTeacher(o1, o2);

  compareParent = (o1: IParent | null, o2: IParent | null): boolean => this.parentService.compareParent(o1, o2);

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ child }) => {
      this.child = child;
      if (child) {
        this.updateForm(child);
      }

      this.loadRelationshipsOptions();
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const child = this.childFormService.getChild(this.editForm);
    if (child.id !== null) {
      this.subscribeToSaveResponse(this.childService.update(child));
    } else {
      this.subscribeToSaveResponse(this.childService.create(child));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IChild>>): void {
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

  protected updateForm(child: IChild): void {
    this.child = child;
    this.childFormService.resetForm(this.editForm, child);

    this.geoFencesCollection = this.geoFenceService.addGeoFenceToCollectionIfMissing<IGeoFence>(this.geoFencesCollection, child.geoFence);
    this.batteryStatusesCollection = this.batteryStatusService.addBatteryStatusToCollectionIfMissing<IBatteryStatus>(
      this.batteryStatusesCollection,
      child.batteryStatus,
    );
    this.teachersSharedCollection = this.teacherService.addTeacherToCollectionIfMissing<ITeacher>(
      this.teachersSharedCollection,
      child.teacher,
    );
    this.parentsSharedCollection = this.parentService.addParentToCollectionIfMissing<IParent>(this.parentsSharedCollection, child.parent);
  }

  protected loadRelationshipsOptions(): void {
    this.geoFenceService
      .query({ filter: 'child-is-null' })
      .pipe(map((res: HttpResponse<IGeoFence[]>) => res.body ?? []))
      .pipe(
        map((geoFences: IGeoFence[]) => this.geoFenceService.addGeoFenceToCollectionIfMissing<IGeoFence>(geoFences, this.child?.geoFence)),
      )
      .subscribe((geoFences: IGeoFence[]) => (this.geoFencesCollection = geoFences));

    this.batteryStatusService
      .query({ filter: 'child-is-null' })
      .pipe(map((res: HttpResponse<IBatteryStatus[]>) => res.body ?? []))
      .pipe(
        map((batteryStatuses: IBatteryStatus[]) =>
          this.batteryStatusService.addBatteryStatusToCollectionIfMissing<IBatteryStatus>(batteryStatuses, this.child?.batteryStatus),
        ),
      )
      .subscribe((batteryStatuses: IBatteryStatus[]) => (this.batteryStatusesCollection = batteryStatuses));

    this.teacherService
      .query()
      .pipe(map((res: HttpResponse<ITeacher[]>) => res.body ?? []))
      .pipe(map((teachers: ITeacher[]) => this.teacherService.addTeacherToCollectionIfMissing<ITeacher>(teachers, this.child?.teacher)))
      .subscribe((teachers: ITeacher[]) => (this.teachersSharedCollection = teachers));

    this.parentService
      .query()
      .pipe(map((res: HttpResponse<IParent[]>) => res.body ?? []))
      .pipe(map((parents: IParent[]) => this.parentService.addParentToCollectionIfMissing<IParent>(parents, this.child?.parent)))
      .subscribe((parents: IParent[]) => (this.parentsSharedCollection = parents));
  }
}
