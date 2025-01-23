package com.diviso.habittrackbackend.web.rest;

import com.diviso.habittrackbackend.domain.HabitTracker;
import com.diviso.habittrackbackend.repository.HabitTrackerRepository;
import com.diviso.habittrackbackend.web.rest.errors.BadRequestAlertException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Objects;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import tech.jhipster.web.util.HeaderUtil;
import tech.jhipster.web.util.reactive.ResponseUtil;

/**
 * REST controller for managing {@link com.diviso.habittrackbackend.domain.HabitTracker}.
 */
@RestController
@RequestMapping("/api/habit-trackers")
@Transactional
public class HabitTrackerResource {

    private static final Logger LOG = LoggerFactory.getLogger(HabitTrackerResource.class);

    private static final String ENTITY_NAME = "habitTracker";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final HabitTrackerRepository habitTrackerRepository;

    public HabitTrackerResource(HabitTrackerRepository habitTrackerRepository) {
        this.habitTrackerRepository = habitTrackerRepository;
    }

    /**
     * {@code POST  /habit-trackers} : Create a new habitTracker.
     *
     * @param habitTracker the habitTracker to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new habitTracker, or with status {@code 400 (Bad Request)} if the habitTracker has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public Mono<ResponseEntity<HabitTracker>> createHabitTracker(@RequestBody HabitTracker habitTracker) throws URISyntaxException {
        LOG.debug("REST request to save HabitTracker : {}", habitTracker);
        if (habitTracker.getId() != null) {
            throw new BadRequestAlertException("A new habitTracker cannot already have an ID", ENTITY_NAME, "idexists");
        }
        return habitTrackerRepository
            .save(habitTracker)
            .map(result -> {
                try {
                    return ResponseEntity.created(new URI("/api/habit-trackers/" + result.getId()))
                        .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
                        .body(result);
                } catch (URISyntaxException e) {
                    throw new RuntimeException(e);
                }
            });
    }

    /**
     * {@code PUT  /habit-trackers/:id} : Updates an existing habitTracker.
     *
     * @param id the id of the habitTracker to save.
     * @param habitTracker the habitTracker to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated habitTracker,
     * or with status {@code 400 (Bad Request)} if the habitTracker is not valid,
     * or with status {@code 500 (Internal Server Error)} if the habitTracker couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public Mono<ResponseEntity<HabitTracker>> updateHabitTracker(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody HabitTracker habitTracker
    ) throws URISyntaxException {
        LOG.debug("REST request to update HabitTracker : {}, {}", id, habitTracker);
        if (habitTracker.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, habitTracker.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        return habitTrackerRepository
            .existsById(id)
            .flatMap(exists -> {
                if (!exists) {
                    return Mono.error(new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound"));
                }

                return habitTrackerRepository
                    .save(habitTracker)
                    .switchIfEmpty(Mono.error(new ResponseStatusException(HttpStatus.NOT_FOUND)))
                    .map(result ->
                        ResponseEntity.ok()
                            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
                            .body(result)
                    );
            });
    }

    /**
     * {@code PATCH  /habit-trackers/:id} : Partial updates given fields of an existing habitTracker, field will ignore if it is null
     *
     * @param id the id of the habitTracker to save.
     * @param habitTracker the habitTracker to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated habitTracker,
     * or with status {@code 400 (Bad Request)} if the habitTracker is not valid,
     * or with status {@code 404 (Not Found)} if the habitTracker is not found,
     * or with status {@code 500 (Internal Server Error)} if the habitTracker couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public Mono<ResponseEntity<HabitTracker>> partialUpdateHabitTracker(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody HabitTracker habitTracker
    ) throws URISyntaxException {
        LOG.debug("REST request to partial update HabitTracker partially : {}, {}", id, habitTracker);
        if (habitTracker.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, habitTracker.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        return habitTrackerRepository
            .existsById(id)
            .flatMap(exists -> {
                if (!exists) {
                    return Mono.error(new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound"));
                }

                Mono<HabitTracker> result = habitTrackerRepository
                    .findById(habitTracker.getId())
                    .map(existingHabitTracker -> {
                        if (habitTracker.getHabitId() != null) {
                            existingHabitTracker.setHabitId(habitTracker.getHabitId());
                        }
                        if (habitTracker.getHabitName() != null) {
                            existingHabitTracker.setHabitName(habitTracker.getHabitName());
                        }
                        if (habitTracker.getDescription() != null) {
                            existingHabitTracker.setDescription(habitTracker.getDescription());
                        }
                        if (habitTracker.getStartDate() != null) {
                            existingHabitTracker.setStartDate(habitTracker.getStartDate());
                        }
                        if (habitTracker.getEndDate() != null) {
                            existingHabitTracker.setEndDate(habitTracker.getEndDate());
                        }

                        return existingHabitTracker;
                    })
                    .flatMap(habitTrackerRepository::save);

                return result
                    .switchIfEmpty(Mono.error(new ResponseStatusException(HttpStatus.NOT_FOUND)))
                    .map(res ->
                        ResponseEntity.ok()
                            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, res.getId().toString()))
                            .body(res)
                    );
            });
    }

    /**
     * {@code GET  /habit-trackers} : get all the habitTrackers.
     *
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of habitTrackers in body.
     */
    @GetMapping(value = "", produces = MediaType.APPLICATION_JSON_VALUE)
    public Mono<List<HabitTracker>> getAllHabitTrackers() {
        LOG.debug("REST request to get all HabitTrackers");
        return habitTrackerRepository.findAll().collectList();
    }

    /**
     * {@code GET  /habit-trackers} : get all the habitTrackers as a stream.
     * @return the {@link Flux} of habitTrackers.
     */
    @GetMapping(value = "", produces = MediaType.APPLICATION_NDJSON_VALUE)
    public Flux<HabitTracker> getAllHabitTrackersAsStream() {
        LOG.debug("REST request to get all HabitTrackers as a stream");
        return habitTrackerRepository.findAll();
    }

    /**
     * {@code GET  /habit-trackers/:id} : get the "id" habitTracker.
     *
     * @param id the id of the habitTracker to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the habitTracker, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public Mono<ResponseEntity<HabitTracker>> getHabitTracker(@PathVariable("id") Long id) {
        LOG.debug("REST request to get HabitTracker : {}", id);
        Mono<HabitTracker> habitTracker = habitTrackerRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(habitTracker);
    }

    /**
     * {@code DELETE  /habit-trackers/:id} : delete the "id" habitTracker.
     *
     * @param id the id of the habitTracker to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public Mono<ResponseEntity<Void>> deleteHabitTracker(@PathVariable("id") Long id) {
        LOG.debug("REST request to delete HabitTracker : {}", id);
        return habitTrackerRepository
            .deleteById(id)
            .then(
                Mono.just(
                    ResponseEntity.noContent()
                        .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
                        .build()
                )
            );
    }
}
