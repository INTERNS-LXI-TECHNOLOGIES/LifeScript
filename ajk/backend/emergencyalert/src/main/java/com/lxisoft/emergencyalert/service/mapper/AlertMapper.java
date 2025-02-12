package com.lxisoft.emergencyalert.service.mapper;

import com.lxisoft.emergencyalert.domain.Alert;
import com.lxisoft.emergencyalert.domain.Child;
import com.lxisoft.emergencyalert.service.dto.AlertDTO;
import com.lxisoft.emergencyalert.service.dto.ChildDTO;
import org.mapstruct.*;

/**
 * Mapper for the entity {@link Alert} and its DTO {@link AlertDTO}.
 */
@Mapper(componentModel = "spring")
public interface AlertMapper extends EntityMapper<AlertDTO, Alert> {
    @Mapping(target = "child", source = "child", qualifiedByName = "childId")
    AlertDTO toDto(Alert s);

    @Named("childId")
    @BeanMapping(ignoreByDefault = true)
    @Mapping(target = "id", source = "id")
    ChildDTO toDtoChildId(Child child);
}
