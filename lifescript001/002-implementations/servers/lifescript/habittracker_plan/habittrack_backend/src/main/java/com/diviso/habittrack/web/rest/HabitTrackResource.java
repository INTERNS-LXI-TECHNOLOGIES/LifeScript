package com.diviso.habittrack.web.rest;

import com.diviso.habittrack.domain.HabitTrack;
import com.diviso.habittrack.repository.HabitTrackRepository;
import com.diviso.habittrack.web.rest.errors.BadRequestAlertException;
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
 * REST controller for managing {@link com.diviso.habittrack.domain.HabitTrack}.
 */
@RestController
@RequestMapping("/api/habit-tracks")
@Transactional
public class HabitTrackResource {

    private static final Logger LOG = LoggerFactory.getLogger(HabitTrackResource.class);

    private static final String ENTITY_NAME = "habitTrack";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final HabitTrackRepository habitTrackRepository;

    public HabitTrackResource(HabitTrackRepository habitTrackRepository) {
        this.habitTrackRepository = habitTrackRepository;
    }

    /**
     * {@code POST  /habit-tracks} : Create a new habitTrack.
     *
     * @param habitTrack the habitTrack to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new habitTrack, or with status {@code 400 (Bad Request)} if the habitTrack has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<HabitTrack> createHabitTrack(@RequestBody HabitTrack habitTrack) throws URISyntaxException {
        LOG.debug("REST request to save HabitTrack : {}", habitTrack);
        if (habitTrack.getId() != null) {
            throw new BadRequestAlertException("A new habitTrack cannot already have an ID", ENTITY_NAME, "idexists");
        }
        habitTrack = habitTrackRepository.save(habitTrack);
        return ResponseEntity.created(new URI("/api/habit-tracks/" + habitTrack.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, habitTrack.getId().toString()))
            .body(habitTrack);
    }

    /**
     * {@code PUT  /habit-tracks/:id} : Updates an existing habitTrack.
     *
     * @param id the id of the habitTrack to save.
     * @param habitTrack the habitTrack to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated habitTrack,
     * or with status {@code 400 (Bad Request)} if the habitTrack is not valid,
     * or with status {@code 500 (Internal Server Error)} if the habitTrack couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<HabitTrack> updateHabitTrack(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody HabitTrack habitTrack
    ) throws URISyntaxException {
        LOG.debug("REST request to update HabitTrack : {}, {}", id, habitTrack);
        if (habitTrack.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, habitTrack.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!habitTrackRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        habitTrack = habitTrackRepository.save(habitTrack);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, habitTrack.getId().toString()))
            .body(habitTrack);
    }

    /**
     * {@code PATCH  /habit-tracks/:id} : Partial updates given fields of an existing habitTrack, field will ignore if it is null
     *
     * @param id the id of the habitTrack to save.
     * @param habitTrack the habitTrack to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated habitTrack,
     * or with status {@code 400 (Bad Request)} if the habitTrack is not valid,
     * or with status {@code 404 (Not Found)} if the habitTrack is not found,
     * or with status {@code 500 (Internal Server Error)} if the habitTrack couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<HabitTrack> partialUpdateHabitTrack(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody HabitTrack habitTrack
    ) throws URISyntaxException {
        LOG.debug("REST request to partial update HabitTrack partially : {}, {}", id, habitTrack);
        if (habitTrack.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, habitTrack.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!habitTrackRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<HabitTrack> result = habitTrackRepository
            .findById(habitTrack.getId())
            .map(existingHabitTrack -> {
                if (habitTrack.getHabitId() != null) {
                    existingHabitTrack.setHabitId(habitTrack.getHabitId());
                }
                if (habitTrack.getHabitName() != null) {
                    existingHabitTrack.setHabitName(habitTrack.getHabitName());
                }
                if (habitTrack.getDescription() != null) {
                    existingHabitTrack.setDescription(habitTrack.getDescription());
                }
                if (habitTrack.getCategory() != null) {
                    existingHabitTrack.setCategory(habitTrack.getCategory());
                }
                if (habitTrack.getStartDate() != null) {
                    existingHabitTrack.setStartDate(habitTrack.getStartDate());
                }
                if (habitTrack.getEndDate() != null) {
                    existingHabitTrack.setEndDate(habitTrack.getEndDate());
                }

                return existingHabitTrack;
            })
            .map(habitTrackRepository::save);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, habitTrack.getId().toString())
        );
    }

    /**
     * {@code GET  /habit-tracks} : get all the habitTracks.
     *
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of habitTracks in body.
     */
    @GetMapping("")
    public List<HabitTrack> getAllHabitTracks() {
        LOG.debug("REST request to get all HabitTracks");
        return habitTrackRepository.findAll();
    }

    /**
     * {@code GET  /habit-tracks/:id} : get the "id" habitTrack.
     *
     * @param id the id of the habitTrack to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the habitTrack, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<HabitTrack> getHabitTrack(@PathVariable("id") Long id) {
        LOG.debug("REST request to get HabitTrack : {}", id);
        Optional<HabitTrack> habitTrack = habitTrackRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(habitTrack);
    }

    /**
     * {@code DELETE  /habit-tracks/:id} : delete the "id" habitTrack.
     *
     * @param id the id of the habitTrack to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteHabitTrack(@PathVariable("id") Long id) {
        LOG.debug("REST request to delete HabitTrack : {}", id);
        habitTrackRepository.deleteById(id);
        return ResponseEntity.noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}
