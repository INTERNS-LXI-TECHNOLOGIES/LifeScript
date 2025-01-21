package com.diviso.perfectday.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicLong;

public class PerfectDayTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    public static PerfectDay getPerfectDaySample1() {
        return new PerfectDay().id(1L).title("title1").description("description1");
    }

    public static PerfectDay getPerfectDaySample2() {
        return new PerfectDay().id(2L).title("title2").description("description2");
    }

    public static PerfectDay getPerfectDayRandomSampleGenerator() {
        return new PerfectDay()
            .id(longCount.incrementAndGet())
            .title(UUID.randomUUID().toString())
            .description(UUID.randomUUID().toString());
    }
}
