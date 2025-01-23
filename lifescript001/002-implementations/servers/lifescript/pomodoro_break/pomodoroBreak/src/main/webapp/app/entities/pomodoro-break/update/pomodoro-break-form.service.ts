import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import dayjs from 'dayjs/esm';
import { DATE_TIME_FORMAT } from 'app/config/input.constants';
import { IPomodoroBreak, NewPomodoroBreak } from '../pomodoro-break.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IPomodoroBreak for edit and NewPomodoroBreakFormGroupInput for create.
 */
type PomodoroBreakFormGroupInput = IPomodoroBreak | PartialWithRequiredKeyOf<NewPomodoroBreak>;

/**
 * Type that converts some properties for forms.
 */
type FormValueOf<T extends IPomodoroBreak | NewPomodoroBreak> = Omit<T, 'dateOfPomodoro' | 'timeOfPomodoroCreation'> & {
  dateOfPomodoro?: string | null;
  timeOfPomodoroCreation?: string | null;
};

type PomodoroBreakFormRawValue = FormValueOf<IPomodoroBreak>;

type NewPomodoroBreakFormRawValue = FormValueOf<NewPomodoroBreak>;

type PomodoroBreakFormDefaults = Pick<NewPomodoroBreak, 'id' | 'dateOfPomodoro' | 'timeOfPomodoroCreation' | 'notificationForBreak'>;

type PomodoroBreakFormGroupContent = {
  id: FormControl<PomodoroBreakFormRawValue['id'] | NewPomodoroBreak['id']>;
  totalWorkingHour: FormControl<PomodoroBreakFormRawValue['totalWorkingHour']>;
  dailyDurationOfWork: FormControl<PomodoroBreakFormRawValue['dailyDurationOfWork']>;
  splitBreakDuration: FormControl<PomodoroBreakFormRawValue['splitBreakDuration']>;
  breakDuration: FormControl<PomodoroBreakFormRawValue['breakDuration']>;
  completedBreaks: FormControl<PomodoroBreakFormRawValue['completedBreaks']>;
  dateOfPomodoro: FormControl<PomodoroBreakFormRawValue['dateOfPomodoro']>;
  timeOfPomodoroCreation: FormControl<PomodoroBreakFormRawValue['timeOfPomodoroCreation']>;
  notificationForBreak: FormControl<PomodoroBreakFormRawValue['notificationForBreak']>;
  finalMessage: FormControl<PomodoroBreakFormRawValue['finalMessage']>;
};

export type PomodoroBreakFormGroup = FormGroup<PomodoroBreakFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class PomodoroBreakFormService {
  createPomodoroBreakFormGroup(pomodoroBreak: PomodoroBreakFormGroupInput = { id: null }): PomodoroBreakFormGroup {
    const pomodoroBreakRawValue = this.convertPomodoroBreakToPomodoroBreakRawValue({
      ...this.getFormDefaults(),
      ...pomodoroBreak,
    });
    return new FormGroup<PomodoroBreakFormGroupContent>({
      id: new FormControl(
        { value: pomodoroBreakRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      totalWorkingHour: new FormControl(pomodoroBreakRawValue.totalWorkingHour),
      dailyDurationOfWork: new FormControl(pomodoroBreakRawValue.dailyDurationOfWork),
      splitBreakDuration: new FormControl(pomodoroBreakRawValue.splitBreakDuration),
      breakDuration: new FormControl(pomodoroBreakRawValue.breakDuration),
      completedBreaks: new FormControl(pomodoroBreakRawValue.completedBreaks),
      dateOfPomodoro: new FormControl(pomodoroBreakRawValue.dateOfPomodoro),
      timeOfPomodoroCreation: new FormControl(pomodoroBreakRawValue.timeOfPomodoroCreation),
      notificationForBreak: new FormControl(pomodoroBreakRawValue.notificationForBreak),
      finalMessage: new FormControl(pomodoroBreakRawValue.finalMessage),
    });
  }

  getPomodoroBreak(form: PomodoroBreakFormGroup): IPomodoroBreak | NewPomodoroBreak {
    return this.convertPomodoroBreakRawValueToPomodoroBreak(form.getRawValue() as PomodoroBreakFormRawValue | NewPomodoroBreakFormRawValue);
  }

  resetForm(form: PomodoroBreakFormGroup, pomodoroBreak: PomodoroBreakFormGroupInput): void {
    const pomodoroBreakRawValue = this.convertPomodoroBreakToPomodoroBreakRawValue({ ...this.getFormDefaults(), ...pomodoroBreak });
    form.reset(
      {
        ...pomodoroBreakRawValue,
        id: { value: pomodoroBreakRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): PomodoroBreakFormDefaults {
    const currentTime = dayjs();

    return {
      id: null,
      dateOfPomodoro: currentTime,
      timeOfPomodoroCreation: currentTime,
      notificationForBreak: false,
    };
  }

  private convertPomodoroBreakRawValueToPomodoroBreak(
    rawPomodoroBreak: PomodoroBreakFormRawValue | NewPomodoroBreakFormRawValue,
  ): IPomodoroBreak | NewPomodoroBreak {
    return {
      ...rawPomodoroBreak,
      dateOfPomodoro: dayjs(rawPomodoroBreak.dateOfPomodoro, DATE_TIME_FORMAT),
      timeOfPomodoroCreation: dayjs(rawPomodoroBreak.timeOfPomodoroCreation, DATE_TIME_FORMAT),
    };
  }

  private convertPomodoroBreakToPomodoroBreakRawValue(
    pomodoroBreak: IPomodoroBreak | (Partial<NewPomodoroBreak> & PomodoroBreakFormDefaults),
  ): PomodoroBreakFormRawValue | PartialWithRequiredKeyOf<NewPomodoroBreakFormRawValue> {
    return {
      ...pomodoroBreak,
      dateOfPomodoro: pomodoroBreak.dateOfPomodoro ? pomodoroBreak.dateOfPomodoro.format(DATE_TIME_FORMAT) : undefined,
      timeOfPomodoroCreation: pomodoroBreak.timeOfPomodoroCreation
        ? pomodoroBreak.timeOfPomodoroCreation.format(DATE_TIME_FORMAT)
        : undefined,
    };
  }
}
