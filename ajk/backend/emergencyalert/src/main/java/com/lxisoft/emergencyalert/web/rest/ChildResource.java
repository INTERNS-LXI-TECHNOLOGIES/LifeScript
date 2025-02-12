package com.lxisoft.emergencyalert.web.rest;

import com.lxisoft.emergencyalert.repository.ChildRepository;
import com.lxisoft.emergencyalert.service.ChildService;
import com.lxisoft.emergencyalert.service.dto.ChildDTO;
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
 * REST controller for managing {@link com.lxisoft.emergencyalert.domain.Child}.
 */
@RestController
@RequestMapping("/api/children")
public class ChildResource {

    private static final Logger LOG = LoggerFactory.getLogger(ChildResource.class);

    private static final String ENTITY_NAME = "child";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final ChildService childService;

    private final ChildRepository childRepository;

    public ChildResource(ChildService childService, ChildRepository childRepository) {
        this.childService = childService;
        this.childRepository = childRepository;
    }

    /**
     * {@code POST  /children} : Create a new child.
     *
     * @param childDTO the childDTO to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new childDTO, or with status {@code 400 (Bad Request)} if the child has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<ChildDTO> createChild(@Valid @RequestBody ChildDTO childDTO) throws URISyntaxException {
        LOG.debug("REST request to save Child : {}", childDTO);
        if (childDTO.getId() != null) {
            throw new BadRequestAlertException("A new child cannot already have an ID", ENTITY_NAME, "idexists");
        }
        childDTO = childService.save(childDTO);
        return ResponseEntity.created(new URI("/api/children/" + childDTO.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, childDTO.getId().toString()))
            .body(childDTO);
    }

    /**
     * {@code PUT  /children/:id} : Updates an existing child.
     *
     * @param id the id of the childDTO to save.
     * @param childDTO the childDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated childDTO,
     * or with status {@code 400 (Bad Request)} if the childDTO is not valid,
     * or with status {@code 500 (Internal Server Error)} if the childDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<ChildDTO> updateChild(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody ChildDTO childDTO
    ) throws URISyntaxException {
        LOG.debug("REST request to update Child : {}, {}", id, childDTO);
        if (childDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, childDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!childRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        childDTO = childService.update(childDTO);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, childDTO.getId().toString()))
            .body(childDTO);
    }

    /**
     * {@code PATCH  /children/:id} : Partial updates given fields of an existing child, field will ignore if it is null
     *
     * @param id the id of the childDTO to save.
     * @param childDTO the childDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated childDTO,
     * or with status {@code 400 (Bad Request)} if the childDTO is not valid,
     * or with status {@code 404 (Not Found)} if the childDTO is not found,
     * or with status {@code 500 (Internal Server Error)} if the childDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<ChildDTO> partialUpdateChild(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody ChildDTO childDTO
    ) throws URISyntaxException {
        LOG.debug("REST request to partial update Child partially : {}, {}", id, childDTO);
        if (childDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, childDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!childRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<ChildDTO> result = childService.partialUpdate(childDTO);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, childDTO.getId().toString())
        );
    }

    /**
     * {@code GET  /children} : get all the children.
     *
     * @param pageable the pagination information.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of children in body.
     */
    @GetMapping("")
    public ResponseEntity<List<ChildDTO>> getAllChildren(@org.springdoc.core.annotations.ParameterObject Pageable pageable) {
        LOG.debug("REST request to get a page of Children");
        Page<ChildDTO> page = childService.findAll(pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

    /**
     * {@code GET  /children/:id} : get the "id" child.
     *
     * @param id the id of the childDTO to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the childDTO, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<ChildDTO> getChild(@PathVariable("id") Long id) {
        LOG.debug("REST request to get Child : {}", id);
        Optional<ChildDTO> childDTO = childService.findOne(id);
        return ResponseUtil.wrapOrNotFound(childDTO);
    }

    /**
     * {@code DELETE  /children/:id} : delete the "id" child.
     *
     * @param id the id of the childDTO to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteChild(@PathVariable("id") Long id) {
        LOG.debug("REST request to delete Child : {}", id);
        childService.delete(id);
        return ResponseEntity.noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}
