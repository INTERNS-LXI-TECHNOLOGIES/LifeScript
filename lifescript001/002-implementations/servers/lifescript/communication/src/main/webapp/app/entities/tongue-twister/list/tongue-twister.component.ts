import { Component, NgZone, OnInit, inject, signal } from '@angular/core';
import { ActivatedRoute, Data, ParamMap, Router, RouterModule } from '@angular/router';
import { Observable, Subscription, combineLatest, filter, tap } from 'rxjs';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { SortByDirective, SortDirective, SortService, type SortState, sortStateSignal } from 'app/shared/sort';
import { FormsModule } from '@angular/forms';
import { DEFAULT_SORT_DATA, ITEM_DELETED_EVENT, SORT } from 'app/config/navigation.constants';
import { ITongueTwister } from '../tongue-twister.model';
import { EntityArrayResponseType, TongueTwisterService } from '../service/tongue-twister.service';
import { TongueTwisterDeleteDialogComponent } from '../delete/tongue-twister-delete-dialog.component';

@Component({
  selector: 'jhi-tongue-twister',
  templateUrl: './tongue-twister.component.html',
  imports: [RouterModule, FormsModule, SharedModule, SortDirective, SortByDirective],
})
export class TongueTwisterComponent implements OnInit {
  subscription: Subscription | null = null;
  tongueTwisters = signal<ITongueTwister[]>([]);
  isLoading = false;

  sortState = sortStateSignal({});

  public readonly router = inject(Router);
  protected readonly tongueTwisterService = inject(TongueTwisterService);
  protected readonly activatedRoute = inject(ActivatedRoute);
  protected readonly sortService = inject(SortService);
  protected modalService = inject(NgbModal);
  protected ngZone = inject(NgZone);

  trackId = (item: ITongueTwister): number => this.tongueTwisterService.getTongueTwisterIdentifier(item);

  ngOnInit(): void {
    this.subscription = combineLatest([this.activatedRoute.queryParamMap, this.activatedRoute.data])
      .pipe(
        tap(([params, data]) => this.fillComponentAttributeFromRoute(params, data)),
        tap(() => {
          if (this.tongueTwisters().length === 0) {
            this.load();
          } else {
            this.tongueTwisters.set(this.refineData(this.tongueTwisters()));
          }
        }),
      )
      .subscribe();
  }

  delete(tongueTwister: ITongueTwister): void {
    const modalRef = this.modalService.open(TongueTwisterDeleteDialogComponent, { size: 'lg', backdrop: 'static' });
    modalRef.componentInstance.tongueTwister = tongueTwister;
    // unsubscribe not needed because closed completes on modal close
    modalRef.closed
      .pipe(
        filter(reason => reason === ITEM_DELETED_EVENT),
        tap(() => this.load()),
      )
      .subscribe();
  }

  load(): void {
    this.queryBackend().subscribe({
      next: (res: EntityArrayResponseType) => {
        this.onResponseSuccess(res);
      },
    });
  }

  navigateToWithComponentValues(event: SortState): void {
    this.handleNavigation(event);
  }

  protected fillComponentAttributeFromRoute(params: ParamMap, data: Data): void {
    this.sortState.set(this.sortService.parseSortParam(params.get(SORT) ?? data[DEFAULT_SORT_DATA]));
  }

  protected onResponseSuccess(response: EntityArrayResponseType): void {
    const dataFromBody = this.fillComponentAttributesFromResponseBody(response.body);
    this.tongueTwisters.set(this.refineData(dataFromBody));
  }

  protected refineData(data: ITongueTwister[]): ITongueTwister[] {
    const { predicate, order } = this.sortState();
    return predicate && order ? data.sort(this.sortService.startSort({ predicate, order })) : data;
  }

  protected fillComponentAttributesFromResponseBody(data: ITongueTwister[] | null): ITongueTwister[] {
    return data ?? [];
  }

  protected queryBackend(): Observable<EntityArrayResponseType> {
    this.isLoading = true;
    const queryObject: any = {
      eagerload: true,
      sort: this.sortService.buildSortParam(this.sortState()),
    };
    return this.tongueTwisterService.query(queryObject).pipe(tap(() => (this.isLoading = false)));
  }

  protected handleNavigation(sortState: SortState): void {
    const queryParamsObj = {
      sort: this.sortService.buildSortParam(sortState),
    };

    this.ngZone.run(() => {
      this.router.navigate(['./'], {
        relativeTo: this.activatedRoute,
        queryParams: queryParamsObj,
      });
    });
  }
}
