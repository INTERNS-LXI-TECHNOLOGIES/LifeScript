package com.lxisoft.emergencyalert.service.impl;

import com.lxisoft.emergencyalert.domain.Child;
import com.lxisoft.emergencyalert.repository.ChildRepository;
import com.lxisoft.emergencyalert.service.ChildService;
import com.lxisoft.emergencyalert.service.dto.ChildDTO;
import com.lxisoft.emergencyalert.service.mapper.ChildMapper;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.lxisoft.emergencyalert.domain.Child}.
 */
@Service
@Transactional
public class ChildServiceImpl implements ChildService {

    private static final Logger LOG = LoggerFactory.getLogger(ChildServiceImpl.class);

    private final ChildRepository childRepository;

    private final ChildMapper childMapper;

    public ChildServiceImpl(ChildRepository childRepository, ChildMapper childMapper) {
        this.childRepository = childRepository;
        this.childMapper = childMapper;
    }

    @Override
    public ChildDTO save(ChildDTO childDTO) {
        LOG.debug("Request to save Child : {}", childDTO);
        Child child = childMapper.toEntity(childDTO);
        child = childRepository.save(child);
        return childMapper.toDto(child);
    }

    @Override
    public ChildDTO update(ChildDTO childDTO) {
        LOG.debug("Request to update Child : {}", childDTO);
        Child child = childMapper.toEntity(childDTO);
        child = childRepository.save(child);
        return childMapper.toDto(child);
    }

    @Override
    public Optional<ChildDTO> partialUpdate(ChildDTO childDTO) {
        LOG.debug("Request to partially update Child : {}", childDTO);

        return childRepository
            .findById(childDTO.getId())
            .map(existingChild -> {
                childMapper.partialUpdate(existingChild, childDTO);

                return existingChild;
            })
            .map(childRepository::save)
            .map(childMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<ChildDTO> findAll(Pageable pageable) {
        LOG.debug("Request to get all Children");
        return childRepository.findAll(pageable).map(childMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<ChildDTO> findOne(Long id) {
        LOG.debug("Request to get Child : {}", id);
        return childRepository.findById(id).map(childMapper::toDto);
    }

    @Override
    public void delete(Long id) {
        LOG.debug("Request to delete Child : {}", id);
        childRepository.deleteById(id);
    }
}
