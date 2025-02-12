package com.lxisoft.emergencyalert.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicLong;

public class GpsEntryTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    public static GpsEntry getGpsEntrySample1() {
        return new GpsEntry().id(1L).deviceId("deviceId1").status("status1");
    }

    public static GpsEntry getGpsEntrySample2() {
        return new GpsEntry().id(2L).deviceId("deviceId2").status("status2");
    }

    public static GpsEntry getGpsEntryRandomSampleGenerator() {
        return new GpsEntry().id(longCount.incrementAndGet()).deviceId(UUID.randomUUID().toString()).status(UUID.randomUUID().toString());
    }
}
