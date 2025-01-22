package com.diviso.web.rest;

import com.diviso.domain.TongueTwister;
import com.diviso.repository.TongueTwisterRepository;
import com.diviso.web.rest.errors.BadRequestAlertException;
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
 * REST controller for managing {@link com.diviso.domain.TongueTwister}.
 */
@RestController
@RequestMapping("/api/tongue-twisters")
@Transactional
public class TongueTwisterResource {

    private static final Logger LOG = LoggerFactory.getLogger(TongueTwisterResource.class);

    private static final String ENTITY_NAME = "tongueTwister";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final TongueTwisterRepository tongueTwisterRepository;

    public TongueTwisterResource(TongueTwisterRepository tongueTwisterRepository) {
        this.tongueTwisterRepository = tongueTwisterRepository;
    }

    /**
     * {@code POST  /tongue-twisters} : Create a new tongueTwister.
     *
     * @param tongueTwister the tongueTwister to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new tongueTwister, or with status {@code 400 (Bad Request)} if the tongueTwister has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<TongueTwister> createTongueTwister(@Valid @RequestBody TongueTwister tongueTwister) throws URISyntaxException {
        LOG.debug("REST request to save TongueTwister : {}", tongueTwister);
        if (tongueTwister.getId() != null) {
            throw new BadRequestAlertException("A new tongueTwister cannot already have an ID", ENTITY_NAME, "idexists");
        }
        tongueTwister = tongueTwisterRepository.save(tongueTwister);
        return ResponseEntity.created(new URI("/api/tongue-twisters/" + tongueTwister.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, tongueTwister.getId().toString()))
            .body(tongueTwister);
    }

    /**
     * {@code PUT  /tongue-twisters/:id} : Updates an existing tongueTwister.
     *
     * @param id the id of the tongueTwister to save.
     * @param tongueTwister the tongueTwister to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated tongueTwister,
     * or with status {@code 400 (Bad Request)} if the tongueTwister is not valid,
     * or with status {@code 500 (Internal Server Error)} if the tongueTwister couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<TongueTwister> updateTongueTwister(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody TongueTwister tongueTwister
    ) throws URISyntaxException {
        LOG.debug("REST request to update TongueTwister : {}, {}", id, tongueTwister);
        if (tongueTwister.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, tongueTwister.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!tongueTwisterRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        tongueTwister = tongueTwisterRepository.save(tongueTwister);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, tongueTwister.getId().toString()))
            .body(tongueTwister);
    }

    /**
     * {@code PATCH  /tongue-twisters/:id} : Partial updates given fields of an existing tongueTwister, field will ignore if it is null
     *
     * @param id the id of the tongueTwister to save.
     * @param tongueTwister the tongueTwister to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated tongueTwister,
     * or with status {@code 400 (Bad Request)} if the tongueTwister is not valid,
     * or with status {@code 404 (Not Found)} if the tongueTwister is not found,
     * or with status {@code 500 (Internal Server Error)} if the tongueTwister couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<TongueTwister> partialUpdateTongueTwister(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody TongueTwister tongueTwister
    ) throws URISyntaxException {
        LOG.debug("REST request to partial update TongueTwister partially : {}, {}", id, tongueTwister);
        if (tongueTwister.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, tongueTwister.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!tongueTwisterRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<TongueTwister> result = tongueTwisterRepository
            .findById(tongueTwister.getId())
            .map(existingTongueTwister -> {
                if (tongueTwister.getText() != null) {
                    existingTongueTwister.setText(tongueTwister.getText());
                }
                if (tongueTwister.getLanguage() != null) {
                    existingTongueTwister.setLanguage(tongueTwister.getLanguage());
                }
                if (tongueTwister.getDifficultyLevel() != null) {
                    existingTongueTwister.setDifficultyLevel(tongueTwister.getDifficultyLevel());
                }

                return existingTongueTwister;
            })
            .map(tongueTwisterRepository::save);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, tongueTwister.getId().toString())
        );
    }

    /**
     * {@code GET  /tongue-twisters} : get all the tongueTwisters.
     *
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of tongueTwisters in body.
     */
    @GetMapping("")
    public List<TongueTwister> getAllTongueTwisters() {
        LOG.debug("REST request to get all TongueTwisters");
        return tongueTwisterRepository.findAll();
    }

    /**
     * {@code GET  /tongue-twisters/:id} : get the "id" tongueTwister.
     *
     * @param id the id of the tongueTwister to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the tongueTwister, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<TongueTwister> getTongueTwister(@PathVariable("id") Long id) {
        LOG.debug("REST request to get TongueTwister : {}", id);
        Optional<TongueTwister> tongueTwister = tongueTwisterRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(tongueTwister);
    }

    /**
     * {@code DELETE  /tongue-twisters/:id} : delete the "id" tongueTwister.
     *
     * @param id the id of the tongueTwister to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTongueTwister(@PathVariable("id") Long id) {
        LOG.debug("REST request to delete TongueTwister : {}", id);
        tongueTwisterRepository.deleteById(id);
        return ResponseEntity.noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}
