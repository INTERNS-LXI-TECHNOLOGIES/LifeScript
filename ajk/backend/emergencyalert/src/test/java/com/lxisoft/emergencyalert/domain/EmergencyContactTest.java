package com.lxisoft.emergencyalert.domain;

import static com.lxisoft.emergencyalert.domain.EmergencyContactTestSamples.*;
import static com.lxisoft.emergencyalert.domain.ParentTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.lxisoft.emergencyalert.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class EmergencyContactTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(EmergencyContact.class);
        EmergencyContact emergencyContact1 = getEmergencyContactSample1();
        EmergencyContact emergencyContact2 = new EmergencyContact();
        assertThat(emergencyContact1).isNotEqualTo(emergencyContact2);

        emergencyContact2.setId(emergencyContact1.getId());
        assertThat(emergencyContact1).isEqualTo(emergencyContact2);

        emergencyContact2 = getEmergencyContactSample2();
        assertThat(emergencyContact1).isNotEqualTo(emergencyContact2);
    }

    @Test
    void parentTest() {
        EmergencyContact emergencyContact = getEmergencyContactRandomSampleGenerator();
        Parent parentBack = getParentRandomSampleGenerator();

        emergencyContact.setParent(parentBack);
        assertThat(emergencyContact.getParent()).isEqualTo(parentBack);

        emergencyContact.parent(null);
        assertThat(emergencyContact.getParent()).isNull();
    }
}
