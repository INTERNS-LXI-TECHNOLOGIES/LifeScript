package com.lxisoft.emergencyalert.service.mapper;

import com.lxisoft.emergencyalert.domain.BatteryStatus;
import com.lxisoft.emergencyalert.domain.Child;
import com.lxisoft.emergencyalert.domain.GeoFence;
import com.lxisoft.emergencyalert.domain.Parent;
import com.lxisoft.emergencyalert.domain.Teacher;
import com.lxisoft.emergencyalert.service.dto.BatteryStatusDTO;
import com.lxisoft.emergencyalert.service.dto.ChildDTO;
import com.lxisoft.emergencyalert.service.dto.GeoFenceDTO;
import com.lxisoft.emergencyalert.service.dto.ParentDTO;
import com.lxisoft.emergencyalert.service.dto.TeacherDTO;
import org.mapstruct.*;

/**
 * Mapper for the entity {@link Child} and its DTO {@link ChildDTO}.
 */
@Mapper(componentModel = "spring")
public interface ChildMapper extends EntityMapper<ChildDTO, Child> {
    @Mapping(target = "geoFence", source = "geoFence", qualifiedByName = "geoFenceId")
    @Mapping(target = "batteryStatus", source = "batteryStatus", qualifiedByName = "batteryStatusId")
    @Mapping(target = "teacher", source = "teacher", qualifiedByName = "teacherId")
    @Mapping(target = "parent", source = "parent", qualifiedByName = "parentId")
    ChildDTO toDto(Child s);

    @Named("geoFenceId")
    @BeanMapping(ignoreByDefault = true)
    @Mapping(target = "id", source = "id")
    GeoFenceDTO toDtoGeoFenceId(GeoFence geoFence);

    @Named("batteryStatusId")
    @BeanMapping(ignoreByDefault = true)
    @Mapping(target = "id", source = "id")
    BatteryStatusDTO toDtoBatteryStatusId(BatteryStatus batteryStatus);

    @Named("teacherId")
    @BeanMapping(ignoreByDefault = true)
    @Mapping(target = "id", source = "id")
    TeacherDTO toDtoTeacherId(Teacher teacher);

    @Named("parentId")
    @BeanMapping(ignoreByDefault = true)
    @Mapping(target = "id", source = "id")
    ParentDTO toDtoParentId(Parent parent);
}
