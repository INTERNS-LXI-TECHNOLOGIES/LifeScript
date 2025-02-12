package com.lxisoft.emergencyalert.domain;

import static com.lxisoft.emergencyalert.domain.ChildTestSamples.*;
import static com.lxisoft.emergencyalert.domain.EmergencyContactTestSamples.*;
import static com.lxisoft.emergencyalert.domain.ParentTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.lxisoft.emergencyalert.web.rest.TestUtil;
import java.util.HashSet;
import java.util.Set;
import org.junit.jupiter.api.Test;

class ParentTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(Parent.class);
        Parent parent1 = getParentSample1();
        Parent parent2 = new Parent();
        assertThat(parent1).isNotEqualTo(parent2);

        parent2.setId(parent1.getId());
        assertThat(parent1).isEqualTo(parent2);

        parent2 = getParentSample2();
        assertThat(parent1).isNotEqualTo(parent2);
    }

    @Test
    void childrenTest() {
        Parent parent = getParentRandomSampleGenerator();
        Child childBack = getChildRandomSampleGenerator();

        parent.addChildren(childBack);
        assertThat(parent.getChildren()).containsOnly(childBack);
        assertThat(childBack.getParent()).isEqualTo(parent);

        parent.removeChildren(childBack);
        assertThat(parent.getChildren()).doesNotContain(childBack);
        assertThat(childBack.getParent()).isNull();

        parent.children(new HashSet<>(Set.of(childBack)));
        assertThat(parent.getChildren()).containsOnly(childBack);
        assertThat(childBack.getParent()).isEqualTo(parent);

        parent.setChildren(new HashSet<>());
        assertThat(parent.getChildren()).doesNotContain(childBack);
        assertThat(childBack.getParent()).isNull();
    }

    @Test
    void emergencyContactsTest() {
        Parent parent = getParentRandomSampleGenerator();
        EmergencyContact emergencyContactBack = getEmergencyContactRandomSampleGenerator();

        parent.addEmergencyContacts(emergencyContactBack);
        assertThat(parent.getEmergencyContacts()).containsOnly(emergencyContactBack);
        assertThat(emergencyContactBack.getParent()).isEqualTo(parent);

        parent.removeEmergencyContacts(emergencyContactBack);
        assertThat(parent.getEmergencyContacts()).doesNotContain(emergencyContactBack);
        assertThat(emergencyContactBack.getParent()).isNull();

        parent.emergencyContacts(new HashSet<>(Set.of(emergencyContactBack)));
        assertThat(parent.getEmergencyContacts()).containsOnly(emergencyContactBack);
        assertThat(emergencyContactBack.getParent()).isEqualTo(parent);

        parent.setEmergencyContacts(new HashSet<>());
        assertThat(parent.getEmergencyContacts()).doesNotContain(emergencyContactBack);
        assertThat(emergencyContactBack.getParent()).isNull();
    }
}
