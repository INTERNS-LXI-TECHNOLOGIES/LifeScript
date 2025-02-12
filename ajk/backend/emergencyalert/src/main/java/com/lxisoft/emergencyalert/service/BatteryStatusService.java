package com.lxisoft.emergencyalert.service;

import com.lxisoft.emergencyalert.service.dto.BatteryStatusDTO;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * Service Interface for managing {@link com.lxisoft.emergencyalert.domain.BatteryStatus}.
 */
public interface BatteryStatusService {
    /**
     * Save a batteryStatus.
     *
     * @param batteryStatusDTO the entity to save.
     * @return the persisted entity.
     */
    BatteryStatusDTO save(BatteryStatusDTO batteryStatusDTO);

    /**
     * Updates a batteryStatus.
     *
     * @param batteryStatusDTO the entity to update.
     * @return the persisted entity.
     */
    BatteryStatusDTO update(BatteryStatusDTO batteryStatusDTO);

    /**
     * Partially updates a batteryStatus.
     *
     * @param batteryStatusDTO the entity to update partially.
     * @return the persisted entity.
     */
    Optional<BatteryStatusDTO> partialUpdate(BatteryStatusDTO batteryStatusDTO);

    /**
     * Get all the batteryStatuses.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    Page<BatteryStatusDTO> findAll(Pageable pageable);

    /**
     * Get all the BatteryStatusDTO where Child is {@code null}.
     *
     * @return the {@link List} of entities.
     */
    List<BatteryStatusDTO> findAllWhereChildIsNull();

    /**
     * Get the "id" batteryStatus.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    Optional<BatteryStatusDTO> findOne(Long id);

    /**
     * Delete the "id" batteryStatus.
     *
     * @param id the id of the entity.
     */
    void delete(Long id);
}
