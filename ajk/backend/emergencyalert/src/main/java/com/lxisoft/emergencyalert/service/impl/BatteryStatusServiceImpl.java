package com.lxisoft.emergencyalert.service.impl;

import com.lxisoft.emergencyalert.domain.BatteryStatus;
import com.lxisoft.emergencyalert.repository.BatteryStatusRepository;
import com.lxisoft.emergencyalert.service.BatteryStatusService;
import com.lxisoft.emergencyalert.service.dto.BatteryStatusDTO;
import com.lxisoft.emergencyalert.service.mapper.BatteryStatusMapper;
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
 * Service Implementation for managing {@link com.lxisoft.emergencyalert.domain.BatteryStatus}.
 */
@Service
@Transactional
public class BatteryStatusServiceImpl implements BatteryStatusService {

    private static final Logger LOG = LoggerFactory.getLogger(BatteryStatusServiceImpl.class);

    private final BatteryStatusRepository batteryStatusRepository;

    private final BatteryStatusMapper batteryStatusMapper;

    public BatteryStatusServiceImpl(BatteryStatusRepository batteryStatusRepository, BatteryStatusMapper batteryStatusMapper) {
        this.batteryStatusRepository = batteryStatusRepository;
        this.batteryStatusMapper = batteryStatusMapper;
    }

    @Override
    public BatteryStatusDTO save(BatteryStatusDTO batteryStatusDTO) {
        LOG.debug("Request to save BatteryStatus : {}", batteryStatusDTO);
        BatteryStatus batteryStatus = batteryStatusMapper.toEntity(batteryStatusDTO);
        batteryStatus = batteryStatusRepository.save(batteryStatus);
        return batteryStatusMapper.toDto(batteryStatus);
    }

    @Override
    public BatteryStatusDTO update(BatteryStatusDTO batteryStatusDTO) {
        LOG.debug("Request to update BatteryStatus : {}", batteryStatusDTO);
        BatteryStatus batteryStatus = batteryStatusMapper.toEntity(batteryStatusDTO);
        batteryStatus = batteryStatusRepository.save(batteryStatus);
        return batteryStatusMapper.toDto(batteryStatus);
    }

    @Override
    public Optional<BatteryStatusDTO> partialUpdate(BatteryStatusDTO batteryStatusDTO) {
        LOG.debug("Request to partially update BatteryStatus : {}", batteryStatusDTO);

        return batteryStatusRepository
            .findById(batteryStatusDTO.getId())
            .map(existingBatteryStatus -> {
                batteryStatusMapper.partialUpdate(existingBatteryStatus, batteryStatusDTO);

                return existingBatteryStatus;
            })
            .map(batteryStatusRepository::save)
            .map(batteryStatusMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<BatteryStatusDTO> findAll(Pageable pageable) {
        LOG.debug("Request to get all BatteryStatuses");
        return batteryStatusRepository.findAll(pageable).map(batteryStatusMapper::toDto);
    }

    /**
     *  Get all the batteryStatuses where Child is {@code null}.
     *  @return the list of entities.
     */
    @Transactional(readOnly = true)
    public List<BatteryStatusDTO> findAllWhereChildIsNull() {
        LOG.debug("Request to get all batteryStatuses where Child is null");
        return StreamSupport.stream(batteryStatusRepository.findAll().spliterator(), false)
            .filter(batteryStatus -> batteryStatus.getChild() == null)
            .map(batteryStatusMapper::toDto)
            .collect(Collectors.toCollection(LinkedList::new));
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<BatteryStatusDTO> findOne(Long id) {
        LOG.debug("Request to get BatteryStatus : {}", id);
        return batteryStatusRepository.findById(id).map(batteryStatusMapper::toDto);
    }

    @Override
    public void delete(Long id) {
        LOG.debug("Request to delete BatteryStatus : {}", id);
        batteryStatusRepository.deleteById(id);
    }
}
