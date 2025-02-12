package com.lxisoft.emergencyalert.service.dto;

import static org.assertj.core.api.Assertions.assertThat;

import com.lxisoft.emergencyalert.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class GpsEntryDTOTest {

    @Test
    void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(GpsEntryDTO.class);
        GpsEntryDTO gpsEntryDTO1 = new GpsEntryDTO();
        gpsEntryDTO1.setId(1L);
        GpsEntryDTO gpsEntryDTO2 = new GpsEntryDTO();
        assertThat(gpsEntryDTO1).isNotEqualTo(gpsEntryDTO2);
        gpsEntryDTO2.setId(gpsEntryDTO1.getId());
        assertThat(gpsEntryDTO1).isEqualTo(gpsEntryDTO2);
        gpsEntryDTO2.setId(2L);
        assertThat(gpsEntryDTO1).isNotEqualTo(gpsEntryDTO2);
        gpsEntryDTO1.setId(null);
        assertThat(gpsEntryDTO1).isNotEqualTo(gpsEntryDTO2);
    }
}
