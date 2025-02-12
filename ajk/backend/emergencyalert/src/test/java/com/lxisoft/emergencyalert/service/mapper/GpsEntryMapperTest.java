package com.lxisoft.emergencyalert.service.mapper;

import static com.lxisoft.emergencyalert.domain.GpsEntryAsserts.*;
import static com.lxisoft.emergencyalert.domain.GpsEntryTestSamples.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class GpsEntryMapperTest {

    private GpsEntryMapper gpsEntryMapper;

    @BeforeEach
    void setUp() {
        gpsEntryMapper = new GpsEntryMapperImpl();
    }

    @Test
    void shouldConvertToDtoAndBack() {
        var expected = getGpsEntrySample1();
        var actual = gpsEntryMapper.toEntity(gpsEntryMapper.toDto(expected));
        assertGpsEntryAllPropertiesEquals(expected, actual);
    }
}
