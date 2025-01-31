package com.diviso.habittrack.domain;

import static com.diviso.habittrack.domain.HabitTrackTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.diviso.habittrack.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class HabitTrackTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(HabitTrack.class);
        HabitTrack habitTrack1 = getHabitTrackSample1();
        HabitTrack habitTrack2 = new HabitTrack();
        assertThat(habitTrack1).isNotEqualTo(habitTrack2);

        habitTrack2.setId(habitTrack1.getId());
        assertThat(habitTrack1).isEqualTo(habitTrack2);

        habitTrack2 = getHabitTrackSample2();
        assertThat(habitTrack1).isNotEqualTo(habitTrack2);
    }
}
