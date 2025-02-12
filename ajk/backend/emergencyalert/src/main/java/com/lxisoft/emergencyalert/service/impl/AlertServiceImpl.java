package com.lxisoft.emergencyalert.service.impl;

import com.lxisoft.emergencyalert.domain.Alert;
import com.lxisoft.emergencyalert.repository.AlertRepository;
import com.lxisoft.emergencyalert.service.AlertService;
import com.lxisoft.emergencyalert.service.dto.AlertDTO;
import com.lxisoft.emergencyalert.service.mapper.AlertMapper;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.lxisoft.emergencyalert.domain.Alert}.
 */
@Service
@Transactional
public class AlertServiceImpl implements AlertService {

    private static final Logger LOG = LoggerFactory.getLogger(AlertServiceImpl.class);

    private final AlertRepository alertRepository;

    private final AlertMapper alertMapper;

    public AlertServiceImpl(AlertRepository alertRepository, AlertMapper alertMapper) {
        this.alertRepository = alertRepository;
        this.alertMapper = alertMapper;
    }

    @Override
    public AlertDTO save(AlertDTO alertDTO) {
        LOG.debug("Request to save Alert : {}", alertDTO);
        Alert alert = alertMapper.toEntity(alertDTO);
        alert = alertRepository.save(alert);
        return alertMapper.toDto(alert);
    }

    @Override
    public AlertDTO update(AlertDTO alertDTO) {
        LOG.debug("Request to update Alert : {}", alertDTO);
        Alert alert = alertMapper.toEntity(alertDTO);
        alert = alertRepository.save(alert);
        return alertMapper.toDto(alert);
    }

    @Override
    public Optional<AlertDTO> partialUpdate(AlertDTO alertDTO) {
        LOG.debug("Request to partially update Alert : {}", alertDTO);

        return alertRepository
            .findById(alertDTO.getId())
            .map(existingAlert -> {
                alertMapper.partialUpdate(existingAlert, alertDTO);

                return existingAlert;
            })
            .map(alertRepository::save)
            .map(alertMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<AlertDTO> findAll(Pageable pageable) {
        LOG.debug("Request to get all Alerts");
        return alertRepository.findAll(pageable).map(alertMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<AlertDTO> findOne(Long id) {
        LOG.debug("Request to get Alert : {}", id);
        return alertRepository.findById(id).map(alertMapper::toDto);
    }

    @Override
    public void delete(Long id) {
        LOG.debug("Request to delete Alert : {}", id);
        alertRepository.deleteById(id);
    }
}
