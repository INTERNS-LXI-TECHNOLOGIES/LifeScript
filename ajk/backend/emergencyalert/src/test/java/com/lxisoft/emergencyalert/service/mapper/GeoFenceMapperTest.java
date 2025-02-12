package com.lxisoft.emergencyalert.service.mapper;

import static com.lxisoft.emergencyalert.domain.GeoFenceAsserts.*;
import static com.lxisoft.emergencyalert.domain.GeoFenceTestSamples.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class GeoFenceMapperTest {

    private GeoFenceMapper geoFenceMapper;

    @BeforeEach
    void setUp() {
        geoFenceMapper = new GeoFenceMapperImpl();
    }

    @Test
    void shouldConvertToDtoAndBack() {
        var expected = getGeoFenceSample1();
        var actual = geoFenceMapper.toEntity(geoFenceMapper.toDto(expected));
        assertGeoFenceAllPropertiesEquals(expected, actual);
    }
}
