package com.diviso.habittrackbackend.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

public class HabitTrackerTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));
    private static final AtomicInteger intCount = new AtomicInteger(random.nextInt() + (2 * Short.MAX_VALUE));

    public static HabitTracker getHabitTrackerSample1() {
        return new HabitTracker()
            .id(1L)
            .habitId(1)
            .habitName("habitName1")
            .description("description1")
            .startDate("startDate1")
            .endDate("endDate1");
    }

    public static HabitTracker getHabitTrackerSample2() {
        return new HabitTracker()
            .id(2L)
            .habitId(2)
            .habitName("habitName2")
            .description("description2")
            .startDate("startDate2")
            .endDate("endDate2");
    }

    public static HabitTracker getHabitTrackerRandomSampleGenerator() {
        return new HabitTracker()
            .id(longCount.incrementAndGet())
            .habitId(intCount.incrementAndGet())
            .habitName(UUID.randomUUID().toString())
            .description(UUID.randomUUID().toString())
            .startDate(UUID.randomUUID().toString())
            .endDate(UUID.randomUUID().toString());
    }
}
