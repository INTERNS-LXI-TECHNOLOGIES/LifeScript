package com.lxisoft.emergencyalert.service.mapper;

import com.lxisoft.emergencyalert.domain.GeoFence;
import com.lxisoft.emergencyalert.service.dto.GeoFenceDTO;
import org.mapstruct.*;

/**
 * Mapper for the entity {@link GeoFence} and its DTO {@link GeoFenceDTO}.
 */
@Mapper(componentModel = "spring")
public interface GeoFenceMapper extends EntityMapper<GeoFenceDTO, GeoFence> {}
