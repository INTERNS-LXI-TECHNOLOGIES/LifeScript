package com.lxisoft.emergencyalert.service;

import com.lxisoft.emergencyalert.service.dto.ChildDTO;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * Service Interface for managing {@link com.lxisoft.emergencyalert.domain.Child}.
 */
public interface ChildService {
    /**
     * Save a child.
     *
     * @param childDTO the entity to save.
     * @return the persisted entity.
     */
    ChildDTO save(ChildDTO childDTO);

    /**
     * Updates a child.
     *
     * @param childDTO the entity to update.
     * @return the persisted entity.
     */
    ChildDTO update(ChildDTO childDTO);

    /**
     * Partially updates a child.
     *
     * @param childDTO the entity to update partially.
     * @return the persisted entity.
     */
    Optional<ChildDTO> partialUpdate(ChildDTO childDTO);

    /**
     * Get all the children.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    Page<ChildDTO> findAll(Pageable pageable);

    /**
     * Get the "id" child.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    Optional<ChildDTO> findOne(Long id);

    /**
     * Delete the "id" child.
     *
     * @param id the id of the entity.
     */
    void delete(Long id);
}
