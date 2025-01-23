package com.diviso.perfectday.domain;

import static com.diviso.perfectday.domain.PerfectDayTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.diviso.perfectday.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class PerfectDayTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(PerfectDay.class);
        PerfectDay perfectDay1 = getPerfectDaySample1();
        PerfectDay perfectDay2 = new PerfectDay();
        assertThat(perfectDay1).isNotEqualTo(perfectDay2);

        perfectDay2.setId(perfectDay1.getId());
        assertThat(perfectDay1).isEqualTo(perfectDay2);

        perfectDay2 = getPerfectDaySample2();
        assertThat(perfectDay1).isNotEqualTo(perfectDay2);
    }
}
