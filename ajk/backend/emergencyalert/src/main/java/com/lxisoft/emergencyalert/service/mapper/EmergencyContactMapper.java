package com.lxisoft.emergencyalert.service.mapper;

import com.lxisoft.emergencyalert.domain.EmergencyContact;
import com.lxisoft.emergencyalert.domain.Parent;
import com.lxisoft.emergencyalert.service.dto.EmergencyContactDTO;
import com.lxisoft.emergencyalert.service.dto.ParentDTO;
import org.mapstruct.*;

/**
 * Mapper for the entity {@link EmergencyContact} and its DTO {@link EmergencyContactDTO}.
 */
@Mapper(componentModel = "spring")
public interface EmergencyContactMapper extends EntityMapper<EmergencyContactDTO, EmergencyContact> {
    @Mapping(target = "parent", source = "parent", qualifiedByName = "parentId")
    EmergencyContactDTO toDto(EmergencyContact s);

    @Named("parentId")
    @BeanMapping(ignoreByDefault = true)
    @Mapping(target = "id", source = "id")
    ParentDTO toDtoParentId(Parent parent);
}
