package com.lxisoft.emergencyalert.service.mapper;

import static com.lxisoft.emergencyalert.domain.BatteryStatusAsserts.*;
import static com.lxisoft.emergencyalert.domain.BatteryStatusTestSamples.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class BatteryStatusMapperTest {

    private BatteryStatusMapper batteryStatusMapper;

    @BeforeEach
    void setUp() {
        batteryStatusMapper = new BatteryStatusMapperImpl();
    }

    @Test
    void shouldConvertToDtoAndBack() {
        var expected = getBatteryStatusSample1();
        var actual = batteryStatusMapper.toEntity(batteryStatusMapper.toDto(expected));
        assertBatteryStatusAllPropertiesEquals(expected, actual);
    }
}
