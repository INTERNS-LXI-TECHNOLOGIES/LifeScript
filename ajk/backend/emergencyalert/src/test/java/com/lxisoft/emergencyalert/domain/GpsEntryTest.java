package com.lxisoft.emergencyalert.domain;

import static com.lxisoft.emergencyalert.domain.ChildTestSamples.*;
import static com.lxisoft.emergencyalert.domain.GpsEntryTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.lxisoft.emergencyalert.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class GpsEntryTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(GpsEntry.class);
        GpsEntry gpsEntry1 = getGpsEntrySample1();
        GpsEntry gpsEntry2 = new GpsEntry();
        assertThat(gpsEntry1).isNotEqualTo(gpsEntry2);

        gpsEntry2.setId(gpsEntry1.getId());
        assertThat(gpsEntry1).isEqualTo(gpsEntry2);

        gpsEntry2 = getGpsEntrySample2();
        assertThat(gpsEntry1).isNotEqualTo(gpsEntry2);
    }

    @Test
    void childTest() {
        GpsEntry gpsEntry = getGpsEntryRandomSampleGenerator();
        Child childBack = getChildRandomSampleGenerator();

        gpsEntry.setChild(childBack);
        assertThat(gpsEntry.getChild()).isEqualTo(childBack);

        gpsEntry.child(null);
        assertThat(gpsEntry.getChild()).isNull();
    }
}
