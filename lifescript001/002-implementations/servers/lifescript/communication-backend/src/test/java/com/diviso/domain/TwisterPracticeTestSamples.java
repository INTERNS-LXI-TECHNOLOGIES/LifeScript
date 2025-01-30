package com.diviso.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

public class TwisterPracticeTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));
    private static final AtomicInteger intCount = new AtomicInteger(random.nextInt() + (2 * Short.MAX_VALUE));

    public static TwisterPractice getTwisterPracticeSample1() {
        return new TwisterPractice().id(1L).score(1).timesPracticed(1).corrections("corrections1");
    }

    public static TwisterPractice getTwisterPracticeSample2() {
        return new TwisterPractice().id(2L).score(2).timesPracticed(2).corrections("corrections2");
    }

    public static TwisterPractice getTwisterPracticeRandomSampleGenerator() {
        return new TwisterPractice()
            .id(longCount.incrementAndGet())
            .score(intCount.incrementAndGet())
            .timesPracticed(intCount.incrementAndGet())
            .corrections(UUID.randomUUID().toString());
    }
}
