package com.lxisoft.emergencyalert.service.mapper;

import com.lxisoft.emergencyalert.domain.Child;
import com.lxisoft.emergencyalert.domain.GpsEntry;
import com.lxisoft.emergencyalert.service.dto.ChildDTO;
import com.lxisoft.emergencyalert.service.dto.GpsEntryDTO;
import org.mapstruct.*;

/**
 * Mapper for the entity {@link GpsEntry} and its DTO {@link GpsEntryDTO}.
 */
@Mapper(componentModel = "spring")
public interface GpsEntryMapper extends EntityMapper<GpsEntryDTO, GpsEntry> {
    @Mapping(target = "child", source = "child", qualifiedByName = "childId")
    GpsEntryDTO toDto(GpsEntry s);

    @Named("childId")
    @BeanMapping(ignoreByDefault = true)
    @Mapping(target = "id", source = "id")
    ChildDTO toDtoChildId(Child child);
}
