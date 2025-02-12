package com.lxisoft.emergencyalert.service.dto;

import static org.assertj.core.api.Assertions.assertThat;

import com.lxisoft.emergencyalert.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class BatteryStatusDTOTest {

    @Test
    void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(BatteryStatusDTO.class);
        BatteryStatusDTO batteryStatusDTO1 = new BatteryStatusDTO();
        batteryStatusDTO1.setId(1L);
        BatteryStatusDTO batteryStatusDTO2 = new BatteryStatusDTO();
        assertThat(batteryStatusDTO1).isNotEqualTo(batteryStatusDTO2);
        batteryStatusDTO2.setId(batteryStatusDTO1.getId());
        assertThat(batteryStatusDTO1).isEqualTo(batteryStatusDTO2);
        batteryStatusDTO2.setId(2L);
        assertThat(batteryStatusDTO1).isNotEqualTo(batteryStatusDTO2);
        batteryStatusDTO1.setId(null);
        assertThat(batteryStatusDTO1).isNotEqualTo(batteryStatusDTO2);
    }
}
