package com.lxisoft.emergencyalert.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicLong;

public class TeacherTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    public static Teacher getTeacherSample1() {
        return new Teacher().id(1L).name("name1").school("school1");
    }

    public static Teacher getTeacherSample2() {
        return new Teacher().id(2L).name("name2").school("school2");
    }

    public static Teacher getTeacherRandomSampleGenerator() {
        return new Teacher().id(longCount.incrementAndGet()).name(UUID.randomUUID().toString()).school(UUID.randomUUID().toString());
    }
}
