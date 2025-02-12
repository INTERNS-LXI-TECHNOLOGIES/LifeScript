package com.lxisoft.emergencyalert.web.rest;

import com.lxisoft.emergencyalert.repository.EmergencyContactRepository;
import com.lxisoft.emergencyalert.service.EmergencyContactService;
import com.lxisoft.emergencyalert.service.dto.EmergencyContactDTO;
import com.lxisoft.emergencyalert.web.rest.errors.BadRequestAlertException;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import tech.jhipster.web.util.HeaderUtil;
import tech.jhipster.web.util.PaginationUtil;
import tech.jhipster.web.util.ResponseUtil;

/**
 * REST controller for managing {@link com.lxisoft.emergencyalert.domain.EmergencyContact}.
 */
@RestController
@RequestMapping("/api/emergency-contacts")
public class EmergencyContactResource {

    private static final Logger LOG = LoggerFactory.getLogger(EmergencyContactResource.class);

    private static final String ENTITY_NAME = "emergencyContact";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final EmergencyContactService emergencyContactService;

    private final EmergencyContactRepository emergencyContactRepository;

    public EmergencyContactResource(
        EmergencyContactService emergencyContactService,
        EmergencyContactRepository emergencyContactRepository
    ) {
        this.emergencyContactService = emergencyContactService;
        this.emergencyContactRepository = emergencyContactRepository;
    }

    /**
     * {@code POST  /emergency-contacts} : Create a new emergencyContact.
     *
     * @param emergencyContactDTO the emergencyContactDTO to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new emergencyContactDTO, or with status {@code 400 (Bad Request)} if the emergencyContact has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<EmergencyContactDTO> createEmergencyContact(@Valid @RequestBody EmergencyContactDTO emergencyContactDTO)
        throws URISyntaxException {
        LOG.debug("REST request to save EmergencyContact : {}", emergencyContactDTO);
        if (emergencyContactDTO.getId() != null) {
            throw new BadRequestAlertException("A new emergencyContact cannot already have an ID", ENTITY_NAME, "idexists");
        }
        emergencyContactDTO = emergencyContactService.save(emergencyContactDTO);
        return ResponseEntity.created(new URI("/api/emergency-contacts/" + emergencyContactDTO.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, emergencyContactDTO.getId().toString()))
            .body(emergencyContactDTO);
    }

    /**
     * {@code PUT  /emergency-contacts/:id} : Updates an existing emergencyContact.
     *
     * @param id the id of the emergencyContactDTO to save.
     * @param emergencyContactDTO the emergencyContactDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated emergencyContactDTO,
     * or with status {@code 400 (Bad Request)} if the emergencyContactDTO is not valid,
     * or with status {@code 500 (Internal Server Error)} if the emergencyContactDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<EmergencyContactDTO> updateEmergencyContact(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody EmergencyContactDTO emergencyContactDTO
    ) throws URISyntaxException {
        LOG.debug("REST request to update EmergencyContact : {}, {}", id, emergencyContactDTO);
        if (emergencyContactDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, emergencyContactDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!emergencyContactRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        emergencyContactDTO = emergencyContactService.update(emergencyContactDTO);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, emergencyContactDTO.getId().toString()))
            .body(emergencyContactDTO);
    }

    /**
     * {@code PATCH  /emergency-contacts/:id} : Partial updates given fields of an existing emergencyContact, field will ignore if it is null
     *
     * @param id the id of the emergencyContactDTO to save.
     * @param emergencyContactDTO the emergencyContactDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated emergencyContactDTO,
     * or with status {@code 400 (Bad Request)} if the emergencyContactDTO is not valid,
     * or with status {@code 404 (Not Found)} if the emergencyContactDTO is not found,
     * or with status {@code 500 (Internal Server Error)} if the emergencyContactDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<EmergencyContactDTO> partialUpdateEmergencyContact(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody EmergencyContactDTO emergencyContactDTO
    ) throws URISyntaxException {
        LOG.debug("REST request to partial update EmergencyContact partially : {}, {}", id, emergencyContactDTO);
        if (emergencyContactDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, emergencyContactDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!emergencyContactRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<EmergencyContactDTO> result = emergencyContactService.partialUpdate(emergencyContactDTO);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, emergencyContactDTO.getId().toString())
        );
    }

    /**
     * {@code GET  /emergency-contacts} : get all the emergencyContacts.
     *
     * @param pageable the pagination information.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of emergencyContacts in body.
     */
    @GetMapping("")
    public ResponseEntity<List<EmergencyContactDTO>> getAllEmergencyContacts(
        @org.springdoc.core.annotations.ParameterObject Pageable pageable
    ) {
        LOG.debug("REST request to get a page of EmergencyContacts");
        Page<EmergencyContactDTO> page = emergencyContactService.findAll(pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

    /**
     * {@code GET  /emergency-contacts/:id} : get the "id" emergencyContact.
     *
     * @param id the id of the emergencyContactDTO to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the emergencyContactDTO, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<EmergencyContactDTO> getEmergencyContact(@PathVariable("id") Long id) {
        LOG.debug("REST request to get EmergencyContact : {}", id);
        Optional<EmergencyContactDTO> emergencyContactDTO = emergencyContactService.findOne(id);
        return ResponseUtil.wrapOrNotFound(emergencyContactDTO);
    }

    /**
     * {@code DELETE  /emergency-contacts/:id} : delete the "id" emergencyContact.
     *
     * @param id the id of the emergencyContactDTO to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEmergencyContact(@PathVariable("id") Long id) {
        LOG.debug("REST request to delete EmergencyContact : {}", id);
        emergencyContactService.delete(id);
        return ResponseEntity.noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}
