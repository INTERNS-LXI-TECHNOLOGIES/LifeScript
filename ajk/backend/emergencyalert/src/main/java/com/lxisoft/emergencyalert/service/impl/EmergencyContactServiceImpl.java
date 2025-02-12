package com.lxisoft.emergencyalert.service.impl;

import com.lxisoft.emergencyalert.domain.EmergencyContact;
import com.lxisoft.emergencyalert.repository.EmergencyContactRepository;
import com.lxisoft.emergencyalert.service.EmergencyContactService;
import com.lxisoft.emergencyalert.service.dto.EmergencyContactDTO;
import com.lxisoft.emergencyalert.service.mapper.EmergencyContactMapper;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.lxisoft.emergencyalert.domain.EmergencyContact}.
 */
@Service
@Transactional
public class EmergencyContactServiceImpl implements EmergencyContactService {

    private static final Logger LOG = LoggerFactory.getLogger(EmergencyContactServiceImpl.class);

    private final EmergencyContactRepository emergencyContactRepository;

    private final EmergencyContactMapper emergencyContactMapper;

    public EmergencyContactServiceImpl(
        EmergencyContactRepository emergencyContactRepository,
        EmergencyContactMapper emergencyContactMapper
    ) {
        this.emergencyContactRepository = emergencyContactRepository;
        this.emergencyContactMapper = emergencyContactMapper;
    }

    @Override
    public EmergencyContactDTO save(EmergencyContactDTO emergencyContactDTO) {
        LOG.debug("Request to save EmergencyContact : {}", emergencyContactDTO);
        EmergencyContact emergencyContact = emergencyContactMapper.toEntity(emergencyContactDTO);
        emergencyContact = emergencyContactRepository.save(emergencyContact);
        return emergencyContactMapper.toDto(emergencyContact);
    }

    @Override
    public EmergencyContactDTO update(EmergencyContactDTO emergencyContactDTO) {
        LOG.debug("Request to update EmergencyContact : {}", emergencyContactDTO);
        EmergencyContact emergencyContact = emergencyContactMapper.toEntity(emergencyContactDTO);
        emergencyContact = emergencyContactRepository.save(emergencyContact);
        return emergencyContactMapper.toDto(emergencyContact);
    }

    @Override
    public Optional<EmergencyContactDTO> partialUpdate(EmergencyContactDTO emergencyContactDTO) {
        LOG.debug("Request to partially update EmergencyContact : {}", emergencyContactDTO);

        return emergencyContactRepository
            .findById(emergencyContactDTO.getId())
            .map(existingEmergencyContact -> {
                emergencyContactMapper.partialUpdate(existingEmergencyContact, emergencyContactDTO);

                return existingEmergencyContact;
            })
            .map(emergencyContactRepository::save)
            .map(emergencyContactMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<EmergencyContactDTO> findAll(Pageable pageable) {
        LOG.debug("Request to get all EmergencyContacts");
        return emergencyContactRepository.findAll(pageable).map(emergencyContactMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<EmergencyContactDTO> findOne(Long id) {
        LOG.debug("Request to get EmergencyContact : {}", id);
        return emergencyContactRepository.findById(id).map(emergencyContactMapper::toDto);
    }

    @Override
    public void delete(Long id) {
        LOG.debug("Request to delete EmergencyContact : {}", id);
        emergencyContactRepository.deleteById(id);
    }
}
