package com.divisosoft.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

public class PomodoroBreakTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));
    private static final AtomicInteger intCount = new AtomicInteger(random.nextInt() + (2 * Short.MAX_VALUE));

    public static PomodoroBreak getPomodoroBreakSample1() {
        return new PomodoroBreak()
            .id(1L)
            .totalWorkingHour(1)
            .dailyDurationOfWork(1)
            .splitBreakDuration(1)
            .breakDuration(1)
            .completedBreaks(1)
            .finalMessage("finalMessage1");
    }

    public static PomodoroBreak getPomodoroBreakSample2() {
        return new PomodoroBreak()
            .id(2L)
            .totalWorkingHour(2)
            .dailyDurationOfWork(2)
            .splitBreakDuration(2)
            .breakDuration(2)
            .completedBreaks(2)
            .finalMessage("finalMessage2");
    }

    public static PomodoroBreak getPomodoroBreakRandomSampleGenerator() {
        return new PomodoroBreak()
            .id(longCount.incrementAndGet())
            .totalWorkingHour(intCount.incrementAndGet())
            .dailyDurationOfWork(intCount.incrementAndGet())
            .splitBreakDuration(intCount.incrementAndGet())
            .breakDuration(intCount.incrementAndGet())
            .completedBreaks(intCount.incrementAndGet())
            .finalMessage(UUID.randomUUID().toString());
    }
}
