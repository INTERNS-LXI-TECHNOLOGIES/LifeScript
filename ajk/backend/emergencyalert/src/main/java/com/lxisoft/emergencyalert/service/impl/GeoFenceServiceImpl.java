package com.lxisoft.emergencyalert.service.impl;

import com.lxisoft.emergencyalert.domain.GeoFence;
import com.lxisoft.emergencyalert.repository.GeoFenceRepository;
import com.lxisoft.emergencyalert.service.GeoFenceService;
import com.lxisoft.emergencyalert.service.dto.GeoFenceDTO;
import com.lxisoft.emergencyalert.service.mapper.GeoFenceMapper;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.lxisoft.emergencyalert.domain.GeoFence}.
 */
@Service
@Transactional
public class GeoFenceServiceImpl implements GeoFenceService {

    private static final Logger LOG = LoggerFactory.getLogger(GeoFenceServiceImpl.class);

    private final GeoFenceRepository geoFenceRepository;

    private final GeoFenceMapper geoFenceMapper;

    public GeoFenceServiceImpl(GeoFenceRepository geoFenceRepository, GeoFenceMapper geoFenceMapper) {
        this.geoFenceRepository = geoFenceRepository;
        this.geoFenceMapper = geoFenceMapper;
    }

    @Override
    public GeoFenceDTO save(GeoFenceDTO geoFenceDTO) {
        LOG.debug("Request to save GeoFence : {}", geoFenceDTO);
        GeoFence geoFence = geoFenceMapper.toEntity(geoFenceDTO);
        geoFence = geoFenceRepository.save(geoFence);
        return geoFenceMapper.toDto(geoFence);
    }

    @Override
    public GeoFenceDTO update(GeoFenceDTO geoFenceDTO) {
        LOG.debug("Request to update GeoFence : {}", geoFenceDTO);
        GeoFence geoFence = geoFenceMapper.toEntity(geoFenceDTO);
        geoFence = geoFenceRepository.save(geoFence);
        return geoFenceMapper.toDto(geoFence);
    }

    @Override
    public Optional<GeoFenceDTO> partialUpdate(GeoFenceDTO geoFenceDTO) {
        LOG.debug("Request to partially update GeoFence : {}", geoFenceDTO);

        return geoFenceRepository
            .findById(geoFenceDTO.getId())
            .map(existingGeoFence -> {
                geoFenceMapper.partialUpdate(existingGeoFence, geoFenceDTO);

                return existingGeoFence;
            })
            .map(geoFenceRepository::save)
            .map(geoFenceMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<GeoFenceDTO> findAll(Pageable pageable) {
        LOG.debug("Request to get all GeoFences");
        return geoFenceRepository.findAll(pageable).map(geoFenceMapper::toDto);
    }

    /**
     *  Get all the geoFences where Child is {@code null}.
     *  @return the list of entities.
     */
    @Transactional(readOnly = true)
    public List<GeoFenceDTO> findAllWhereChildIsNull() {
        LOG.debug("Request to get all geoFences where Child is null");
        return StreamSupport.stream(geoFenceRepository.findAll().spliterator(), false)
            .filter(geoFence -> geoFence.getChild() == null)
            .map(geoFenceMapper::toDto)
            .collect(Collectors.toCollection(LinkedList::new));
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<GeoFenceDTO> findOne(Long id) {
        LOG.debug("Request to get GeoFence : {}", id);
        return geoFenceRepository.findById(id).map(geoFenceMapper::toDto);
    }

    @Override
    public void delete(Long id) {
        LOG.debug("Request to delete GeoFence : {}", id);
        geoFenceRepository.deleteById(id);
    }
}
