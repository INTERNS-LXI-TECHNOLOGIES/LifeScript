package com.lxisoft.emergencyalert.service.impl;

import com.lxisoft.emergencyalert.domain.GpsEntry;
import com.lxisoft.emergencyalert.repository.GpsEntryRepository;
import com.lxisoft.emergencyalert.service.GpsEntryService;
import com.lxisoft.emergencyalert.service.dto.GpsEntryDTO;
import com.lxisoft.emergencyalert.service.mapper.GpsEntryMapper;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.lxisoft.emergencyalert.domain.GpsEntry}.
 */
@Service
@Transactional
public class GpsEntryServiceImpl implements GpsEntryService {

    private static final Logger LOG = LoggerFactory.getLogger(GpsEntryServiceImpl.class);

    private final GpsEntryRepository gpsEntryRepository;

    private final GpsEntryMapper gpsEntryMapper;

    public GpsEntryServiceImpl(GpsEntryRepository gpsEntryRepository, GpsEntryMapper gpsEntryMapper) {
        this.gpsEntryRepository = gpsEntryRepository;
        this.gpsEntryMapper = gpsEntryMapper;
    }

    @Override
    public GpsEntryDTO save(GpsEntryDTO gpsEntryDTO) {
        LOG.debug("Request to save GpsEntry : {}", gpsEntryDTO);
        GpsEntry gpsEntry = gpsEntryMapper.toEntity(gpsEntryDTO);
        gpsEntry = gpsEntryRepository.save(gpsEntry);
        return gpsEntryMapper.toDto(gpsEntry);
    }

    @Override
    public GpsEntryDTO update(GpsEntryDTO gpsEntryDTO) {
        LOG.debug("Request to update GpsEntry : {}", gpsEntryDTO);
        GpsEntry gpsEntry = gpsEntryMapper.toEntity(gpsEntryDTO);
        gpsEntry = gpsEntryRepository.save(gpsEntry);
        return gpsEntryMapper.toDto(gpsEntry);
    }

    @Override
    public Optional<GpsEntryDTO> partialUpdate(GpsEntryDTO gpsEntryDTO) {
        LOG.debug("Request to partially update GpsEntry : {}", gpsEntryDTO);

        return gpsEntryRepository
            .findById(gpsEntryDTO.getId())
            .map(existingGpsEntry -> {
                gpsEntryMapper.partialUpdate(existingGpsEntry, gpsEntryDTO);

                return existingGpsEntry;
            })
            .map(gpsEntryRepository::save)
            .map(gpsEntryMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<GpsEntryDTO> findAll(Pageable pageable) {
        LOG.debug("Request to get all GpsEntries");
        return gpsEntryRepository.findAll(pageable).map(gpsEntryMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<GpsEntryDTO> findOne(Long id) {
        LOG.debug("Request to get GpsEntry : {}", id);
        return gpsEntryRepository.findById(id).map(gpsEntryMapper::toDto);
    }

    @Override
    public void delete(Long id) {
        LOG.debug("Request to delete GpsEntry : {}", id);
        gpsEntryRepository.deleteById(id);
    }
}
