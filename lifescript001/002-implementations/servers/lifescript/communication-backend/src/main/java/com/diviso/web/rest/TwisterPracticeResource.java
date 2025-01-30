package com.diviso.web.rest;

import com.diviso.domain.TwisterPractice;
import com.diviso.repository.TwisterPracticeRepository;
import com.diviso.web.rest.errors.BadRequestAlertException;
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
 * REST controller for managing {@link com.diviso.domain.TwisterPractice}.
 */
@RestController
@RequestMapping("/api/twister-practices")
@Transactional
public class TwisterPracticeResource {

    private static final Logger LOG = LoggerFactory.getLogger(TwisterPracticeResource.class);

    private static final String ENTITY_NAME = "twisterPractice";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final TwisterPracticeRepository twisterPracticeRepository;

    public TwisterPracticeResource(TwisterPracticeRepository twisterPracticeRepository) {
        this.twisterPracticeRepository = twisterPracticeRepository;
    }

    /**
     * {@code POST  /twister-practices} : Create a new twisterPractice.
     *
     * @param twisterPractice the twisterPractice to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new twisterPractice, or with status {@code 400 (Bad Request)} if the twisterPractice has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<TwisterPractice> createTwisterPractice(@RequestBody TwisterPractice twisterPractice) throws URISyntaxException {
        LOG.debug("REST request to save TwisterPractice : {}", twisterPractice);
        if (twisterPractice.getId() != null) {
            throw new BadRequestAlertException("A new twisterPractice cannot already have an ID", ENTITY_NAME, "idexists");
        }
        twisterPractice = twisterPracticeRepository.save(twisterPractice);
        return ResponseEntity.created(new URI("/api/twister-practices/" + twisterPractice.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, twisterPractice.getId().toString()))
            .body(twisterPractice);
    }

    /**
     * {@code PUT  /twister-practices/:id} : Updates an existing twisterPractice.
     *
     * @param id the id of the twisterPractice to save.
     * @param twisterPractice the twisterPractice to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated twisterPractice,
     * or with status {@code 400 (Bad Request)} if the twisterPractice is not valid,
     * or with status {@code 500 (Internal Server Error)} if the twisterPractice couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<TwisterPractice> updateTwisterPractice(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody TwisterPractice twisterPractice
    ) throws URISyntaxException {
        LOG.debug("REST request to update TwisterPractice : {}, {}", id, twisterPractice);
        if (twisterPractice.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, twisterPractice.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!twisterPracticeRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        twisterPractice = twisterPracticeRepository.save(twisterPractice);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, twisterPractice.getId().toString()))
            .body(twisterPractice);
    }

    /**
     * {@code PATCH  /twister-practices/:id} : Partial updates given fields of an existing twisterPractice, field will ignore if it is null
     *
     * @param id the id of the twisterPractice to save.
     * @param twisterPractice the twisterPractice to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated twisterPractice,
     * or with status {@code 400 (Bad Request)} if the twisterPractice is not valid,
     * or with status {@code 404 (Not Found)} if the twisterPractice is not found,
     * or with status {@code 500 (Internal Server Error)} if the twisterPractice couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<TwisterPractice> partialUpdateTwisterPractice(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody TwisterPractice twisterPractice
    ) throws URISyntaxException {
        LOG.debug("REST request to partial update TwisterPractice partially : {}, {}", id, twisterPractice);
        if (twisterPractice.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, twisterPractice.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!twisterPracticeRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<TwisterPractice> result = twisterPracticeRepository
            .findById(twisterPractice.getId())
            .map(existingTwisterPractice -> {
                if (twisterPractice.getScore() != null) {
                    existingTwisterPractice.setScore(twisterPractice.getScore());
                }
                if (twisterPractice.getTimesPracticed() != null) {
                    existingTwisterPractice.setTimesPracticed(twisterPractice.getTimesPracticed());
                }
                if (twisterPractice.getCorrections() != null) {
                    existingTwisterPractice.setCorrections(twisterPractice.getCorrections());
                }

                return existingTwisterPractice;
            })
            .map(twisterPracticeRepository::save);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, twisterPractice.getId().toString())
        );
    }

    /**
     * {@code GET  /twister-practices} : get all the twisterPractices.
     *
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of twisterPractices in body.
     */
    @GetMapping("")
    public List<TwisterPractice> getAllTwisterPractices() {
        LOG.debug("REST request to get all TwisterPractices");
        return twisterPracticeRepository.findAll();
    }

    /**
     * {@code GET  /twister-practices/:id} : get the "id" twisterPractice.
     *
     * @param id the id of the twisterPractice to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the twisterPractice, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<TwisterPractice> getTwisterPractice(@PathVariable("id") Long id) {
        LOG.debug("REST request to get TwisterPractice : {}", id);
        Optional<TwisterPractice> twisterPractice = twisterPracticeRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(twisterPractice);
    }

    /**
     * {@code DELETE  /twister-practices/:id} : delete the "id" twisterPractice.
     *
     * @param id the id of the twisterPractice to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTwisterPractice(@PathVariable("id") Long id) {
        LOG.debug("REST request to delete TwisterPractice : {}", id);
        twisterPracticeRepository.deleteById(id);
        return ResponseEntity.noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}
