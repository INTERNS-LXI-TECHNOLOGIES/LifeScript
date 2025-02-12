package com.lxisoft.emergencyalert.domain;

import static com.lxisoft.emergencyalert.domain.BatteryStatusTestSamples.*;
import static com.lxisoft.emergencyalert.domain.ChildTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.lxisoft.emergencyalert.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class BatteryStatusTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(BatteryStatus.class);
        BatteryStatus batteryStatus1 = getBatteryStatusSample1();
        BatteryStatus batteryStatus2 = new BatteryStatus();
        assertThat(batteryStatus1).isNotEqualTo(batteryStatus2);

        batteryStatus2.setId(batteryStatus1.getId());
        assertThat(batteryStatus1).isEqualTo(batteryStatus2);

        batteryStatus2 = getBatteryStatusSample2();
        assertThat(batteryStatus1).isNotEqualTo(batteryStatus2);
    }

    @Test
    void childTest() {
        BatteryStatus batteryStatus = getBatteryStatusRandomSampleGenerator();
        Child childBack = getChildRandomSampleGenerator();

        batteryStatus.setChild(childBack);
        assertThat(batteryStatus.getChild()).isEqualTo(childBack);
        assertThat(childBack.getBatteryStatus()).isEqualTo(batteryStatus);

        batteryStatus.child(null);
        assertThat(batteryStatus.getChild()).isNull();
        assertThat(childBack.getBatteryStatus()).isNull();
    }
}
