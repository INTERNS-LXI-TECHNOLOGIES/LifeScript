package com.lxisoft.emergencyalert.domain;

import static com.lxisoft.emergencyalert.domain.AlertTestSamples.*;
import static com.lxisoft.emergencyalert.domain.BatteryStatusTestSamples.*;
import static com.lxisoft.emergencyalert.domain.ChildTestSamples.*;
import static com.lxisoft.emergencyalert.domain.GeoFenceTestSamples.*;
import static com.lxisoft.emergencyalert.domain.ParentTestSamples.*;
import static com.lxisoft.emergencyalert.domain.TeacherTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.lxisoft.emergencyalert.web.rest.TestUtil;
import java.util.HashSet;
import java.util.Set;
import org.junit.jupiter.api.Test;

class ChildTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(Child.class);
        Child child1 = getChildSample1();
        Child child2 = new Child();
        assertThat(child1).isNotEqualTo(child2);

        child2.setId(child1.getId());
        assertThat(child1).isEqualTo(child2);

        child2 = getChildSample2();
        assertThat(child1).isNotEqualTo(child2);
    }

    @Test
    void geoFenceTest() {
        Child child = getChildRandomSampleGenerator();
        GeoFence geoFenceBack = getGeoFenceRandomSampleGenerator();

        child.setGeoFence(geoFenceBack);
        assertThat(child.getGeoFence()).isEqualTo(geoFenceBack);

        child.geoFence(null);
        assertThat(child.getGeoFence()).isNull();
    }

    @Test
    void batteryStatusTest() {
        Child child = getChildRandomSampleGenerator();
        BatteryStatus batteryStatusBack = getBatteryStatusRandomSampleGenerator();

        child.setBatteryStatus(batteryStatusBack);
        assertThat(child.getBatteryStatus()).isEqualTo(batteryStatusBack);

        child.batteryStatus(null);
        assertThat(child.getBatteryStatus()).isNull();
    }

    @Test
    void alertsTest() {
        Child child = getChildRandomSampleGenerator();
        Alert alertBack = getAlertRandomSampleGenerator();

        child.addAlerts(alertBack);
        assertThat(child.getAlerts()).containsOnly(alertBack);
        assertThat(alertBack.getChild()).isEqualTo(child);

        child.removeAlerts(alertBack);
        assertThat(child.getAlerts()).doesNotContain(alertBack);
        assertThat(alertBack.getChild()).isNull();

        child.alerts(new HashSet<>(Set.of(alertBack)));
        assertThat(child.getAlerts()).containsOnly(alertBack);
        assertThat(alertBack.getChild()).isEqualTo(child);

        child.setAlerts(new HashSet<>());
        assertThat(child.getAlerts()).doesNotContain(alertBack);
        assertThat(alertBack.getChild()).isNull();
    }

    @Test
    void teacherTest() {
        Child child = getChildRandomSampleGenerator();
        Teacher teacherBack = getTeacherRandomSampleGenerator();

        child.setTeacher(teacherBack);
        assertThat(child.getTeacher()).isEqualTo(teacherBack);

        child.teacher(null);
        assertThat(child.getTeacher()).isNull();
    }

    @Test
    void parentTest() {
        Child child = getChildRandomSampleGenerator();
        Parent parentBack = getParentRandomSampleGenerator();

        child.setParent(parentBack);
        assertThat(child.getParent()).isEqualTo(parentBack);

        child.parent(null);
        assertThat(child.getParent()).isNull();
    }
}
