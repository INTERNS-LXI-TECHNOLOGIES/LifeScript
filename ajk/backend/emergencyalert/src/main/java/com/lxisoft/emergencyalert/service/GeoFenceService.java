package com.lxisoft.emergencyalert.service;

import com.lxisoft.emergencyalert.service.dto.GeoFenceDTO;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * Service Interface for managing {@link com.lxisoft.emergencyalert.domain.GeoFence}.
 */
public interface GeoFenceService {
    /**
     * Save a geoFence.
     *
     * @param geoFenceDTO the entity to save.
     * @return the persisted entity.
     */
    GeoFenceDTO save(GeoFenceDTO geoFenceDTO);

    /**
     * Updates a geoFence.
     *
     * @param geoFenceDTO the entity to update.
     * @return the persisted entity.
     */
    GeoFenceDTO update(GeoFenceDTO geoFenceDTO);

    /**
     * Partially updates a geoFence.
     *
     * @param geoFenceDTO the entity to update partially.
     * @return the persisted entity.
     */
    Optional<GeoFenceDTO> partialUpdate(GeoFenceDTO geoFenceDTO);

    /**
     * Get all the geoFences.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    Page<GeoFenceDTO> findAll(Pageable pageable);

    /**
     * Get all the GeoFenceDTO where Child is {@code null}.
     *
     * @return the {@link List} of entities.
     */
    List<GeoFenceDTO> findAllWhereChildIsNull();

    /**
     * Get the "id" geoFence.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    Optional<GeoFenceDTO> findOne(Long id);

    /**
     * Delete the "id" geoFence.
     *
     * @param id the id of the entity.
     */
    void delete(Long id);
}
