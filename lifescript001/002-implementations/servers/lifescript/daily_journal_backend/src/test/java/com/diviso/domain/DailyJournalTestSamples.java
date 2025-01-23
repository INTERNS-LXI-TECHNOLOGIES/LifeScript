package com.diviso.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicLong;

public class DailyJournalTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    public static DailyJournal getDailyJournalSample1() {
        return new DailyJournal().id(1L).title("title1").content("content1");
    }

    public static DailyJournal getDailyJournalSample2() {
        return new DailyJournal().id(2L).title("title2").content("content2");
    }

    public static DailyJournal getDailyJournalRandomSampleGenerator() {
        return new DailyJournal().id(longCount.incrementAndGet()).title(UUID.randomUUID().toString()).content(UUID.randomUUID().toString());
    }
}
