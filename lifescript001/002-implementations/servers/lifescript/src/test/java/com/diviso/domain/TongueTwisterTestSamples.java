package com.diviso.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

public class TongueTwisterTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));
    private static final AtomicInteger intCount = new AtomicInteger(random.nextInt() + (2 * Short.MAX_VALUE));

    public static TongueTwister getTongueTwisterSample1() {
        return new TongueTwister().id(1L).text("text1").language("language1").difficultyLevel(1);
    }

    public static TongueTwister getTongueTwisterSample2() {
        return new TongueTwister().id(2L).text("text2").language("language2").difficultyLevel(2);
    }

    public static TongueTwister getTongueTwisterRandomSampleGenerator() {
        return new TongueTwister()
            .id(longCount.incrementAndGet())
            .text(UUID.randomUUID().toString())
            .language(UUID.randomUUID().toString())
            .difficultyLevel(intCount.incrementAndGet());
    }
}
