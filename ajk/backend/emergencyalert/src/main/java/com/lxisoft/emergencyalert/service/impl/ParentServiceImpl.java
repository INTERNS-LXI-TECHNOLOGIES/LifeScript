package com.lxisoft.emergencyalert.service.impl;

import com.lxisoft.emergencyalert.domain.Parent;
import com.lxisoft.emergencyalert.repository.ParentRepository;
import com.lxisoft.emergencyalert.service.ParentService;
import com.lxisoft.emergencyalert.service.dto.ParentDTO;
import com.lxisoft.emergencyalert.service.mapper.ParentMapper;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.lxisoft.emergencyalert.domain.Parent}.
 */
@Service
@Transactional
public class ParentServiceImpl implements ParentService {

    private static final Logger LOG = LoggerFactory.getLogger(ParentServiceImpl.class);

    private final ParentRepository parentRepository;

    private final ParentMapper parentMapper;

    public ParentServiceImpl(ParentRepository parentRepository, ParentMapper parentMapper) {
        this.parentRepository = parentRepository;
        this.parentMapper = parentMapper;
    }

    @Override
    public ParentDTO save(ParentDTO parentDTO) {
        LOG.debug("Request to save Parent : {}", parentDTO);
        Parent parent = parentMapper.toEntity(parentDTO);
        parent = parentRepository.save(parent);
        return parentMapper.toDto(parent);
    }

    @Override
    public ParentDTO update(ParentDTO parentDTO) {
        LOG.debug("Request to update Parent : {}", parentDTO);
        Parent parent = parentMapper.toEntity(parentDTO);
        parent = parentRepository.save(parent);
        return parentMapper.toDto(parent);
    }

    @Override
    public Optional<ParentDTO> partialUpdate(ParentDTO parentDTO) {
        LOG.debug("Request to partially update Parent : {}", parentDTO);

        return parentRepository
            .findById(parentDTO.getId())
            .map(existingParent -> {
                parentMapper.partialUpdate(existingParent, parentDTO);

                return existingParent;
            })
            .map(parentRepository::save)
            .map(parentMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<ParentDTO> findAll(Pageable pageable) {
        LOG.debug("Request to get all Parents");
        return parentRepository.findAll(pageable).map(parentMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<ParentDTO> findOne(Long id) {
        LOG.debug("Request to get Parent : {}", id);
        return parentRepository.findById(id).map(parentMapper::toDto);
    }

    @Override
    public void delete(Long id) {
        LOG.debug("Request to delete Parent : {}", id);
        parentRepository.deleteById(id);
    }
}
