package com.diviso.perfectday.web.rest;

import com.diviso.perfectday.domain.PerfectDay;
import com.diviso.perfectday.repository.PerfectDayRepository;
import com.diviso.perfectday.web.rest.errors.BadRequestAlertException;
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
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import tech.jhipster.web.util.HeaderUtil;
import tech.jhipster.web.util.ResponseUtil;

/**
 * REST controller for managing {@link com.diviso.perfectday.domain.PerfectDay}.
 */
@RestController
@RequestMapping("/api/perfect-days")
@Transactional
public class PerfectDayResource {

    private static final Logger LOG = LoggerFactory.getLogger(PerfectDayResource.class);

    private static final String ENTITY_NAME = "perfectDay";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final PerfectDayRepository perfectDayRepository;

    public PerfectDayResource(PerfectDayRepository perfectDayRepository) {
        this.perfectDayRepository = perfectDayRepository;
    }

    /**
     * {@code POST  /perfect-days} : Create a new perfectDay.
     *
     * @param perfectDay the perfectDay to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new perfectDay, or with status {@code 400 (Bad Request)} if the perfectDay has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<PerfectDay> createPerfectDay(@Valid @RequestBody PerfectDay perfectDay) throws URISyntaxException {
        LOG.debug("REST request to save PerfectDay : {}", perfectDay);
        if (perfectDay.getId() != null) {
            throw new BadRequestAlertException("A new perfectDay cannot already have an ID", ENTITY_NAME, "idexists");
        }
        perfectDay = perfectDayRepository.save(perfectDay);
        return ResponseEntity.created(new URI("/api/perfect-days/" + perfectDay.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, perfectDay.getId().toString()))
            .body(perfectDay);
    }

    /**
     * {@code PUT  /perfect-days/:id} : Updates an existing perfectDay.
     *
     * @param id the id of the perfectDay to save.
     * @param perfectDay the perfectDay to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated perfectDay,
     * or with status {@code 400 (Bad Request)} if the perfectDay is not valid,
     * or with status {@code 500 (Internal Server Error)} if the perfectDay couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<PerfectDay> updatePerfectDay(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody PerfectDay perfectDay
    ) throws URISyntaxException {
        LOG.debug("REST request to update PerfectDay : {}, {}", id, perfectDay);
        if (perfectDay.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, perfectDay.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!perfectDayRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        perfectDay = perfectDayRepository.save(perfectDay);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, perfectDay.getId().toString()))
            .body(perfectDay);
    }

    /**
     * {@code PATCH  /perfect-days/:id} : Partial updates given fields of an existing perfectDay, field will ignore if it is null
     *
     * @param id the id of the perfectDay to save.
     * @param perfectDay the perfectDay to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated perfectDay,
     * or with status {@code 400 (Bad Request)} if the perfectDay is not valid,
     * or with status {@code 404 (Not Found)} if the perfectDay is not found,
     * or with status {@code 500 (Internal Server Error)} if the perfectDay couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<PerfectDay> partialUpdatePerfectDay(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody PerfectDay perfectDay
    ) throws URISyntaxException {
        LOG.debug("REST request to partial update PerfectDay partially : {}, {}", id, perfectDay);
        if (perfectDay.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, perfectDay.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!perfectDayRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<PerfectDay> result = perfectDayRepository
            .findById(perfectDay.getId())
            .map(existingPerfectDay -> {
                if (perfectDay.getTitle() != null) {
                    existingPerfectDay.setTitle(perfectDay.getTitle());
                }
                if (perfectDay.getDescription() != null) {
                    existingPerfectDay.setDescription(perfectDay.getDescription());
                }
                if (perfectDay.getDate() != null) {
                    existingPerfectDay.setDate(perfectDay.getDate());
                }

                return existingPerfectDay;
            })
            .map(perfectDayRepository::save);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, perfectDay.getId().toString())
        );
    }

    /**
     * {@code GET  /perfect-days} : get all the perfectDays.
     *
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of perfectDays in body.
     */
    @GetMapping("")
    public List<PerfectDay> getAllPerfectDays() {
        LOG.debug("REST request to get all PerfectDays");
        return perfectDayRepository.findAll();
    }

    /**
     * {@code GET  /perfect-days/:id} : get the "id" perfectDay.
     *
     * @param id the id of the perfectDay to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the perfectDay, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<PerfectDay> getPerfectDay(@PathVariable("id") Long id) {
        LOG.debug("REST request to get PerfectDay : {}", id);
        Optional<PerfectDay> perfectDay = perfectDayRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(perfectDay);
    }

    /**
     * {@code DELETE  /perfect-days/:id} : delete the "id" perfectDay.
     *
     * @param id the id of the perfectDay to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePerfectDay(@PathVariable("id") Long id) {
        LOG.debug("REST request to delete PerfectDay : {}", id);
        perfectDayRepository.deleteById(id);
        return ResponseEntity.noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}
