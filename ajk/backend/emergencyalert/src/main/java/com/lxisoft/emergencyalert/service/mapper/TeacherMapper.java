package com.lxisoft.emergencyalert.service.mapper;

import com.lxisoft.emergencyalert.domain.Teacher;
import com.lxisoft.emergencyalert.service.dto.TeacherDTO;
import org.mapstruct.*;

/**
 * Mapper for the entity {@link Teacher} and its DTO {@link TeacherDTO}.
 */
@Mapper(componentModel = "spring")
public interface TeacherMapper extends EntityMapper<TeacherDTO, Teacher> {}
