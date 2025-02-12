package com.lxisoft.emergencyalert.domain;

import static com.lxisoft.emergencyalert.domain.ChildTestSamples.*;
import static com.lxisoft.emergencyalert.domain.GeoFenceTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.lxisoft.emergencyalert.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class GeoFenceTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(GeoFence.class);
        GeoFence geoFence1 = getGeoFenceSample1();
        GeoFence geoFence2 = new GeoFence();
        assertThat(geoFence1).isNotEqualTo(geoFence2);

        geoFence2.setId(geoFence1.getId());
        assertThat(geoFence1).isEqualTo(geoFence2);

        geoFence2 = getGeoFenceSample2();
        assertThat(geoFence1).isNotEqualTo(geoFence2);
    }

    @Test
    void childTest() {
        GeoFence geoFence = getGeoFenceRandomSampleGenerator();
        Child childBack = getChildRandomSampleGenerator();

        geoFence.setChild(childBack);
        assertThat(geoFence.getChild()).isEqualTo(childBack);
        assertThat(childBack.getGeoFence()).isEqualTo(geoFence);

        geoFence.child(null);
        assertThat(geoFence.getChild()).isNull();
        assertThat(childBack.getGeoFence()).isNull();
    }
}
