package com.lxisoft.emergencyalert.service.impl;

import com.lxisoft.emergencyalert.domain.Teacher;
import com.lxisoft.emergencyalert.repository.TeacherRepository;
import com.lxisoft.emergencyalert.service.TeacherService;
import com.lxisoft.emergencyalert.service.dto.TeacherDTO;
import com.lxisoft.emergencyalert.service.mapper.TeacherMapper;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.lxisoft.emergencyalert.domain.Teacher}.
 */
@Service
@Transactional
public class TeacherServiceImpl implements TeacherService {

    private static final Logger LOG = LoggerFactory.getLogger(TeacherServiceImpl.class);

    private final TeacherRepository teacherRepository;

    private final TeacherMapper teacherMapper;

    public TeacherServiceImpl(TeacherRepository teacherRepository, TeacherMapper teacherMapper) {
        this.teacherRepository = teacherRepository;
        this.teacherMapper = teacherMapper;
    }

    @Override
    public TeacherDTO save(TeacherDTO teacherDTO) {
        LOG.debug("Request to save Teacher : {}", teacherDTO);
        Teacher teacher = teacherMapper.toEntity(teacherDTO);
        teacher = teacherRepository.save(teacher);
        return teacherMapper.toDto(teacher);
    }

    @Override
    public TeacherDTO update(TeacherDTO teacherDTO) {
        LOG.debug("Request to update Teacher : {}", teacherDTO);
        Teacher teacher = teacherMapper.toEntity(teacherDTO);
        teacher = teacherRepository.save(teacher);
        return teacherMapper.toDto(teacher);
    }

    @Override
    public Optional<TeacherDTO> partialUpdate(TeacherDTO teacherDTO) {
        LOG.debug("Request to partially update Teacher : {}", teacherDTO);

        return teacherRepository
            .findById(teacherDTO.getId())
            .map(existingTeacher -> {
                teacherMapper.partialUpdate(existingTeacher, teacherDTO);

                return existingTeacher;
            })
            .map(teacherRepository::save)
            .map(teacherMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<TeacherDTO> findAll(Pageable pageable) {
        LOG.debug("Request to get all Teachers");
        return teacherRepository.findAll(pageable).map(teacherMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<TeacherDTO> findOne(Long id) {
        LOG.debug("Request to get Teacher : {}", id);
        return teacherRepository.findById(id).map(teacherMapper::toDto);
    }

    @Override
    public void delete(Long id) {
        LOG.debug("Request to delete Teacher : {}", id);
        teacherRepository.deleteById(id);
    }
}
