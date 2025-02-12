package com.lxisoft.emergencyalert.service.mapper;

import static com.lxisoft.emergencyalert.domain.EmergencyContactAsserts.*;
import static com.lxisoft.emergencyalert.domain.EmergencyContactTestSamples.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class EmergencyContactMapperTest {

    private EmergencyContactMapper emergencyContactMapper;

    @BeforeEach
    void setUp() {
        emergencyContactMapper = new EmergencyContactMapperImpl();
    }

    @Test
    void shouldConvertToDtoAndBack() {
        var expected = getEmergencyContactSample1();
        var actual = emergencyContactMapper.toEntity(emergencyContactMapper.toDto(expected));
        assertEmergencyContactAllPropertiesEquals(expected, actual);
    }
}
