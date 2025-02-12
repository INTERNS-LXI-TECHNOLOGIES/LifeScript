package com.lxisoft.emergencyalert.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicLong;

public class GeoFenceTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    public static GeoFence getGeoFenceSample1() {
        return new GeoFence().id(1L).safeZones("safeZones1");
    }

    public static GeoFence getGeoFenceSample2() {
        return new GeoFence().id(2L).safeZones("safeZones2");
    }

    public static GeoFence getGeoFenceRandomSampleGenerator() {
        return new GeoFence().id(longCount.incrementAndGet()).safeZones(UUID.randomUUID().toString());
    }
}
