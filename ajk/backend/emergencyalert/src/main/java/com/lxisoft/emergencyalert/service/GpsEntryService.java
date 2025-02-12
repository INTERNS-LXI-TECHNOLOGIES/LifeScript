package com.lxisoft.emergencyalert.service;

import com.lxisoft.emergencyalert.service.dto.GpsEntryDTO;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * Service Interface for managing {@link com.lxisoft.emergencyalert.domain.GpsEntry}.
 */
public interface GpsEntryService {
    /**
     * Save a gpsEntry.
     *
     * @param gpsEntryDTO the entity to save.
     * @return the persisted entity.
     */
    GpsEntryDTO save(GpsEntryDTO gpsEntryDTO);

    /**
     * Updates a gpsEntry.
     *
     * @param gpsEntryDTO the entity to update.
     * @return the persisted entity.
     */
    GpsEntryDTO update(GpsEntryDTO gpsEntryDTO);

    /**
     * Partially updates a gpsEntry.
     *
     * @param gpsEntryDTO the entity to update partially.
     * @return the persisted entity.
     */
    Optional<GpsEntryDTO> partialUpdate(GpsEntryDTO gpsEntryDTO);

    /**
     * Get all the gpsEntries.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    Page<GpsEntryDTO> findAll(Pageable pageable);

    /**
     * Get the "id" gpsEntry.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    Optional<GpsEntryDTO> findOne(Long id);

    /**
     * Delete the "id" gpsEntry.
     *
     * @param id the id of the entity.
     */
    void delete(Long id);
}
