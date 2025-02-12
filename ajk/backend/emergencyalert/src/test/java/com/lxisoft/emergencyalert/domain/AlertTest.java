package com.lxisoft.emergencyalert.domain;

import static com.lxisoft.emergencyalert.domain.AlertTestSamples.*;
import static com.lxisoft.emergencyalert.domain.ChildTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.lxisoft.emergencyalert.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class AlertTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(Alert.class);
        Alert alert1 = getAlertSample1();
        Alert alert2 = new Alert();
        assertThat(alert1).isNotEqualTo(alert2);

        alert2.setId(alert1.getId());
        assertThat(alert1).isEqualTo(alert2);

        alert2 = getAlertSample2();
        assertThat(alert1).isNotEqualTo(alert2);
    }

    @Test
    void childTest() {
        Alert alert = getAlertRandomSampleGenerator();
        Child childBack = getChildRandomSampleGenerator();

        alert.setChild(childBack);
        assertThat(alert.getChild()).isEqualTo(childBack);

        alert.child(null);
        assertThat(alert.getChild()).isNull();
    }
}
