package com.demo.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

public class DemoTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));
    private static final AtomicInteger intCount = new AtomicInteger(random.nextInt() + (2 * Short.MAX_VALUE));

    public static Demo getDemoSample1() {
        return new Demo().id(1L).username("username1").mobileNumber(1);
    }

    public static Demo getDemoSample2() {
        return new Demo().id(2L).username("username2").mobileNumber(2);
    }

    public static Demo getDemoRandomSampleGenerator() {
        return new Demo().id(longCount.incrementAndGet()).username(UUID.randomUUID().toString()).mobileNumber(intCount.incrementAndGet());
    }
}
