package com.lxisoft.emergencyalert.web.rest;

import com.lxisoft.emergencyalert.repository.GpsEntryRepository;
import com.lxisoft.emergencyalert.service.GpsEntryService;
import com.lxisoft.emergencyalert.service.dto.GpsEntryDTO;
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
 * REST controller for managing {@link com.lxisoft.emergencyalert.domain.GpsEntry}.
 */
@RestController
@RequestMapping("/api/gps-entries")
public class GpsEntryResource {

    private static final Logger LOG = LoggerFactory.getLogger(GpsEntryResource.class);

    private static final String ENTITY_NAME = "gpsEntry";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final GpsEntryService gpsEntryService;

    private final GpsEntryRepository gpsEntryRepository;

    public GpsEntryResource(GpsEntryService gpsEntryService, GpsEntryRepository gpsEntryRepository) {
        this.gpsEntryService = gpsEntryService;
        this.gpsEntryRepository = gpsEntryRepository;
    }

    /**
     * {@code POST  /gps-entries} : Create a new gpsEntry.
     *
     * @param gpsEntryDTO the gpsEntryDTO to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new gpsEntryDTO, or with status {@code 400 (Bad Request)} if the gpsEntry has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<GpsEntryDTO> createGpsEntry(@Valid @RequestBody GpsEntryDTO gpsEntryDTO) throws URISyntaxException {
        LOG.debug("REST request to save GpsEntry : {}", gpsEntryDTO);
        if (gpsEntryDTO.getId() != null) {
            throw new BadRequestAlertException("A new gpsEntry cannot already have an ID", ENTITY_NAME, "idexists");
        }
        gpsEntryDTO = gpsEntryService.save(gpsEntryDTO);
        return ResponseEntity.created(new URI("/api/gps-entries/" + gpsEntryDTO.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, gpsEntryDTO.getId().toString()))
            .body(gpsEntryDTO);
    }

    /**
     * {@code PUT  /gps-entries/:id} : Updates an existing gpsEntry.
     *
     * @param id the id of the gpsEntryDTO to save.
     * @param gpsEntryDTO the gpsEntryDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated gpsEntryDTO,
     * or with status {@code 400 (Bad Request)} if the gpsEntryDTO is not valid,
     * or with status {@code 500 (Internal Server Error)} if the gpsEntryDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<GpsEntryDTO> updateGpsEntry(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody GpsEntryDTO gpsEntryDTO
    ) throws URISyntaxException {
        LOG.debug("REST request to update GpsEntry : {}, {}", id, gpsEntryDTO);
        if (gpsEntryDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, gpsEntryDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!gpsEntryRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        gpsEntryDTO = gpsEntryService.update(gpsEntryDTO);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, gpsEntryDTO.getId().toString()))
            .body(gpsEntryDTO);
    }

    /**
     * {@code PATCH  /gps-entries/:id} : Partial updates given fields of an existing gpsEntry, field will ignore if it is null
     *
     * @param id the id of the gpsEntryDTO to save.
     * @param gpsEntryDTO the gpsEntryDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated gpsEntryDTO,
     * or with status {@code 400 (Bad Request)} if the gpsEntryDTO is not valid,
     * or with status {@code 404 (Not Found)} if the gpsEntryDTO is not found,
     * or with status {@code 500 (Internal Server Error)} if the gpsEntryDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<GpsEntryDTO> partialUpdateGpsEntry(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody GpsEntryDTO gpsEntryDTO
    ) throws URISyntaxException {
        LOG.debug("REST request to partial update GpsEntry partially : {}, {}", id, gpsEntryDTO);
        if (gpsEntryDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, gpsEntryDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!gpsEntryRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<GpsEntryDTO> result = gpsEntryService.partialUpdate(gpsEntryDTO);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, gpsEntryDTO.getId().toString())
        );
    }

    /**
     * {@code GET  /gps-entries} : get all the gpsEntries.
     *
     * @param pageable the pagination information.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of gpsEntries in body.
     */
    @GetMapping("")
    public ResponseEntity<List<GpsEntryDTO>> getAllGpsEntries(@org.springdoc.core.annotations.ParameterObject Pageable pageable) {
        LOG.debug("REST request to get a page of GpsEntries");
        Page<GpsEntryDTO> page = gpsEntryService.findAll(pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

    /**
     * {@code GET  /gps-entries/:id} : get the "id" gpsEntry.
     *
     * @param id the id of the gpsEntryDTO to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the gpsEntryDTO, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<GpsEntryDTO> getGpsEntry(@PathVariable("id") Long id) {
        LOG.debug("REST request to get GpsEntry : {}", id);
        Optional<GpsEntryDTO> gpsEntryDTO = gpsEntryService.findOne(id);
        return ResponseUtil.wrapOrNotFound(gpsEntryDTO);
    }

    /**
     * {@code DELETE  /gps-entries/:id} : delete the "id" gpsEntry.
     *
     * @param id the id of the gpsEntryDTO to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteGpsEntry(@PathVariable("id") Long id) {
        LOG.debug("REST request to delete GpsEntry : {}", id);
        gpsEntryService.delete(id);
        return ResponseEntity.noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}
