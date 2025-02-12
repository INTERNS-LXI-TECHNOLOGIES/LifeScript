package com.lxisoft.emergencyalert.domain;

import java.util.Random;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

public class BatteryStatusTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));
    private static final AtomicInteger intCount = new AtomicInteger(random.nextInt() + (2 * Short.MAX_VALUE));

    public static BatteryStatus getBatteryStatusSample1() {
        return new BatteryStatus().id(1L).batteryLevel(1);
    }

    public static BatteryStatus getBatteryStatusSample2() {
        return new BatteryStatus().id(2L).batteryLevel(2);
    }

    public static BatteryStatus getBatteryStatusRandomSampleGenerator() {
        return new BatteryStatus().id(longCount.incrementAndGet()).batteryLevel(intCount.incrementAndGet());
    }
}
