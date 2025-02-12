package com.lxisoft.emergencyalert.web.rest;

import com.lxisoft.emergencyalert.repository.GeoFenceRepository;
import com.lxisoft.emergencyalert.service.GeoFenceService;
import com.lxisoft.emergencyalert.service.dto.GeoFenceDTO;
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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import tech.jhipster.web.util.HeaderUtil;
import tech.jhipster.web.util.PaginationUtil;
import tech.jhipster.web.util.ResponseUtil;

/**
 * REST controller for managing {@link com.lxisoft.emergencyalert.domain.GeoFence}.
 */
@RestController
@RequestMapping("/api/geo-fences")
public class GeoFenceResource {

    private static final Logger LOG = LoggerFactory.getLogger(GeoFenceResource.class);

    private static final String ENTITY_NAME = "geoFence";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final GeoFenceService geoFenceService;

    private final GeoFenceRepository geoFenceRepository;

    public GeoFenceResource(GeoFenceService geoFenceService, GeoFenceRepository geoFenceRepository) {
        this.geoFenceService = geoFenceService;
        this.geoFenceRepository = geoFenceRepository;
    }

    /**
     * {@code POST  /geo-fences} : Create a new geoFence.
     *
     * @param geoFenceDTO the geoFenceDTO to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new geoFenceDTO, or with status {@code 400 (Bad Request)} if the geoFence has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<GeoFenceDTO> createGeoFence(@Valid @RequestBody GeoFenceDTO geoFenceDTO) throws URISyntaxException {
        LOG.debug("REST request to save GeoFence : {}", geoFenceDTO);
        if (geoFenceDTO.getId() != null) {
            throw new BadRequestAlertException("A new geoFence cannot already have an ID", ENTITY_NAME, "idexists");
        }
        geoFenceDTO = geoFenceService.save(geoFenceDTO);
        return ResponseEntity.created(new URI("/api/geo-fences/" + geoFenceDTO.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, geoFenceDTO.getId().toString()))
            .body(geoFenceDTO);
    }

    /**
     * {@code PUT  /geo-fences/:id} : Updates an existing geoFence.
     *
     * @param id the id of the geoFenceDTO to save.
     * @param geoFenceDTO the geoFenceDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated geoFenceDTO,
     * or with status {@code 400 (Bad Request)} if the geoFenceDTO is not valid,
     * or with status {@code 500 (Internal Server Error)} if the geoFenceDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<GeoFenceDTO> updateGeoFence(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody GeoFenceDTO geoFenceDTO
    ) throws URISyntaxException {
        LOG.debug("REST request to update GeoFence : {}, {}", id, geoFenceDTO);
        if (geoFenceDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, geoFenceDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!geoFenceRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        geoFenceDTO = geoFenceService.update(geoFenceDTO);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, geoFenceDTO.getId().toString()))
            .body(geoFenceDTO);
    }

    /**
     * {@code PATCH  /geo-fences/:id} : Partial updates given fields of an existing geoFence, field will ignore if it is null
     *
     * @param id the id of the geoFenceDTO to save.
     * @param geoFenceDTO the geoFenceDTO to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated geoFenceDTO,
     * or with status {@code 400 (Bad Request)} if the geoFenceDTO is not valid,
     * or with status {@code 404 (Not Found)} if the geoFenceDTO is not found,
     * or with status {@code 500 (Internal Server Error)} if the geoFenceDTO couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<GeoFenceDTO> partialUpdateGeoFence(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody GeoFenceDTO geoFenceDTO
    ) throws URISyntaxException {
        LOG.debug("REST request to partial update GeoFence partially : {}, {}", id, geoFenceDTO);
        if (geoFenceDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, geoFenceDTO.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!geoFenceRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<GeoFenceDTO> result = geoFenceService.partialUpdate(geoFenceDTO);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, geoFenceDTO.getId().toString())
        );
    }

    /**
     * {@code GET  /geo-fences} : get all the geoFences.
     *
     * @param pageable the pagination information.
     * @param filter the filter of the request.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of geoFences in body.
     */
    @GetMapping("")
    public ResponseEntity<List<GeoFenceDTO>> getAllGeoFences(
        @org.springdoc.core.annotations.ParameterObject Pageable pageable,
        @RequestParam(name = "filter", required = false) String filter
    ) {
        if ("child-is-null".equals(filter)) {
            LOG.debug("REST request to get all GeoFences where child is null");
            return new ResponseEntity<>(geoFenceService.findAllWhereChildIsNull(), HttpStatus.OK);
        }
        LOG.debug("REST request to get a page of GeoFences");
        Page<GeoFenceDTO> page = geoFenceService.findAll(pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

    /**
     * {@code GET  /geo-fences/:id} : get the "id" geoFence.
     *
     * @param id the id of the geoFenceDTO to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the geoFenceDTO, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<GeoFenceDTO> getGeoFence(@PathVariable("id") Long id) {
        LOG.debug("REST request to get GeoFence : {}", id);
        Optional<GeoFenceDTO> geoFenceDTO = geoFenceService.findOne(id);
        return ResponseUtil.wrapOrNotFound(geoFenceDTO);
    }

    /**
     * {@code DELETE  /geo-fences/:id} : delete the "id" geoFence.
     *
     * @param id the id of the geoFenceDTO to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteGeoFence(@PathVariable("id") Long id) {
        LOG.debug("REST request to delete GeoFence : {}", id);
        geoFenceService.delete(id);
        return ResponseEntity.noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}
