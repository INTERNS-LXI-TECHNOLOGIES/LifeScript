package com.diviso.habittrack.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

public class HabitTrackTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));
    private static final AtomicInteger intCount = new AtomicInteger(random.nextInt() + (2 * Short.MAX_VALUE));

    public static HabitTrack getHabitTrackSample1() {
        return new HabitTrack()
            .id(1L)
            .habitId(1)
            .habitName("habitName1")
            .description("description1")
            .category("category1")
            .startDate("startDate1")
            .endDate("endDate1");
    }

    public static HabitTrack getHabitTrackSample2() {
        return new HabitTrack()
            .id(2L)
            .habitId(2)
            .habitName("habitName2")
            .description("description2")
            .category("category2")
            .startDate("startDate2")
            .endDate("endDate2");
    }

    public static HabitTrack getHabitTrackRandomSampleGenerator() {
        return new HabitTrack()
            .id(longCount.incrementAndGet())
            .habitId(intCount.incrementAndGet())
            .habitName(UUID.randomUUID().toString())
            .description(UUID.randomUUID().toString())
            .category(UUID.randomUUID().toString())
            .startDate(UUID.randomUUID().toString())
            .endDate(UUID.randomUUID().toString());
    }
}
