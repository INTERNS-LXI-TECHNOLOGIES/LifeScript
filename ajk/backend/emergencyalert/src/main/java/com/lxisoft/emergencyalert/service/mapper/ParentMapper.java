package com.lxisoft.emergencyalert.service.mapper;

import com.lxisoft.emergencyalert.domain.Parent;
import com.lxisoft.emergencyalert.service.dto.ParentDTO;
import org.mapstruct.*;

/**
 * Mapper for the entity {@link Parent} and its DTO {@link ParentDTO}.
 */
@Mapper(componentModel = "spring")
public interface ParentMapper extends EntityMapper<ParentDTO, Parent> {}
