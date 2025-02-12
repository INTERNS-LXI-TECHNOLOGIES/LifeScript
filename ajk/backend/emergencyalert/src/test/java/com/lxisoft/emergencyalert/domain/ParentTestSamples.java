package com.lxisoft.emergencyalert.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicLong;

public class ParentTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    public static Parent getParentSample1() {
        return new Parent().id(1L).name("name1").phoneNumber("phoneNumber1");
    }

    public static Parent getParentSample2() {
        return new Parent().id(2L).name("name2").phoneNumber("phoneNumber2");
    }

    public static Parent getParentRandomSampleGenerator() {
        return new Parent().id(longCount.incrementAndGet()).name(UUID.randomUUID().toString()).phoneNumber(UUID.randomUUID().toString());
    }
}
