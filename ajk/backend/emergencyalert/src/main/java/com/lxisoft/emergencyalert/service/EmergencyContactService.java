package com.lxisoft.emergencyalert.service;

import com.lxisoft.emergencyalert.service.dto.EmergencyContactDTO;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * Service Interface for managing {@link com.lxisoft.emergencyalert.domain.EmergencyContact}.
 */
public interface EmergencyContactService {
    /**
     * Save a emergencyContact.
     *
     * @param emergencyContactDTO the entity to save.
     * @return the persisted entity.
     */
    EmergencyContactDTO save(EmergencyContactDTO emergencyContactDTO);

    /**
     * Updates a emergencyContact.
     *
     * @param emergencyContactDTO the entity to update.
     * @return the persisted entity.
     */
    EmergencyContactDTO update(EmergencyContactDTO emergencyContactDTO);

    /**
     * Partially updates a emergencyContact.
     *
     * @param emergencyContactDTO the entity to update partially.
     * @return the persisted entity.
     */
    Optional<EmergencyContactDTO> partialUpdate(EmergencyContactDTO emergencyContactDTO);

    /**
     * Get all the emergencyContacts.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    Page<EmergencyContactDTO> findAll(Pageable pageable);

    /**
     * Get the "id" emergencyContact.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    Optional<EmergencyContactDTO> findOne(Long id);

    /**
     * Delete the "id" emergencyContact.
     *
     * @param id the id of the entity.
     */
    void delete(Long id);
}
