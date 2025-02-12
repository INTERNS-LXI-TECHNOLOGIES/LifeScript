package com.lxisoft.emergencyalert.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicLong;

public class EmergencyContactTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    public static EmergencyContact getEmergencyContactSample1() {
        return new EmergencyContact().id(1L).name("name1").type("type1").phoneNumber("phoneNumber1");
    }

    public static EmergencyContact getEmergencyContactSample2() {
        return new EmergencyContact().id(2L).name("name2").type("type2").phoneNumber("phoneNumber2");
    }

    public static EmergencyContact getEmergencyContactRandomSampleGenerator() {
        return new EmergencyContact()
            .id(longCount.incrementAndGet())
            .name(UUID.randomUUID().toString())
            .type(UUID.randomUUID().toString())
            .phoneNumber(UUID.randomUUID().toString());
    }
}
