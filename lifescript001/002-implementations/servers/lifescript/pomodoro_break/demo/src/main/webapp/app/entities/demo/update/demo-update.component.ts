import { Component, OnInit, inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IDemo } from '../demo.model';
import { DemoService } from '../service/demo.service';
import { DemoFormGroup, DemoFormService } from './demo-form.service';

@Component({
  selector: 'jhi-demo-update',
  templateUrl: './demo-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class DemoUpdateComponent implements OnInit {
  isSaving = false;
  demo: IDemo | null = null;

  protected demoService = inject(DemoService);
  protected demoFormService = inject(DemoFormService);
  protected activatedRoute = inject(ActivatedRoute);

  // eslint-disable-next-line @typescript-eslint/member-ordering
  editForm: DemoFormGroup = this.demoFormService.createDemoFormGroup();

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ demo }) => {
      this.demo = demo;
      if (demo) {
        this.updateForm(demo);
      }
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const demo = this.demoFormService.getDemo(this.editForm);
    if (demo.id !== null) {
      this.subscribeToSaveResponse(this.demoService.update(demo));
    } else {
      this.subscribeToSaveResponse(this.demoService.create(demo));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IDemo>>): void {
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

  protected updateForm(demo: IDemo): void {
    this.demo = demo;
    this.demoFormService.resetForm(this.editForm, demo);
  }
}
