package com.lxisoft.emergencyalert.service.mapper;

import static com.lxisoft.emergencyalert.domain.ChildAsserts.*;
import static com.lxisoft.emergencyalert.domain.ChildTestSamples.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ChildMapperTest {

    private ChildMapper childMapper;

    @BeforeEach
    void setUp() {
        childMapper = new ChildMapperImpl();
    }

    @Test
    void shouldConvertToDtoAndBack() {
        var expected = getChildSample1();
        var actual = childMapper.toEntity(childMapper.toDto(expected));
        assertChildAllPropertiesEquals(expected, actual);
    }
}
