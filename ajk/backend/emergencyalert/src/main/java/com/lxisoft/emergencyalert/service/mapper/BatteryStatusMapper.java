package com.lxisoft.emergencyalert.service.mapper;

import com.lxisoft.emergencyalert.domain.BatteryStatus;
import com.lxisoft.emergencyalert.service.dto.BatteryStatusDTO;
import org.mapstruct.*;

/**
 * Mapper for the entity {@link BatteryStatus} and its DTO {@link BatteryStatusDTO}.
 */
@Mapper(componentModel = "spring")
public interface BatteryStatusMapper extends EntityMapper<BatteryStatusDTO, BatteryStatus> {}
