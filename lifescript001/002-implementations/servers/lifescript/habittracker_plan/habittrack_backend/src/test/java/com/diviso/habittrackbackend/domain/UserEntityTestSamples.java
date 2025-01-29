package com.diviso.habittrackbackend.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

public class UserEntityTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));
    private static final AtomicInteger intCount = new AtomicInteger(random.nextInt() + (2 * Short.MAX_VALUE));

    public static UserEntity getUserEntitySample1() {
        return new UserEntity().id(1L).userId(1).userName("userName1");
    }

    public static UserEntity getUserEntitySample2() {
        return new UserEntity().id(2L).userId(2).userName("userName2");
    }

    public static UserEntity getUserEntityRandomSampleGenerator() {
        return new UserEntity().id(longCount.incrementAndGet()).userId(intCount.incrementAndGet()).userName(UUID.randomUUID().toString());
    }
}
