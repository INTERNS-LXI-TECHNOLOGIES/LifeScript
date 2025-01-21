package com.diviso.dailyjournal.domain;

import static com.diviso.dailyjournal.domain.DailyJournalTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.diviso.dailyjournal.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class DailyJournalTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(DailyJournal.class);
        DailyJournal dailyJournal1 = getDailyJournalSample1();
        DailyJournal dailyJournal2 = new DailyJournal();
        assertThat(dailyJournal1).isNotEqualTo(dailyJournal2);

        dailyJournal2.setId(dailyJournal1.getId());
        assertThat(dailyJournal1).isEqualTo(dailyJournal2);

        dailyJournal2 = getDailyJournalSample2();
        assertThat(dailyJournal1).isNotEqualTo(dailyJournal2);
    }
}
