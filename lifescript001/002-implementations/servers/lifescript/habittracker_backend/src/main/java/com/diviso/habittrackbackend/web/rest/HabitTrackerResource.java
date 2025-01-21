package com.diviso.habittrackbackend.web.rest;

import com.diviso.habittrackbackend.domain.HabitTracker;
import com.diviso.habittrackbackend.repository.HabitTrackerRepository;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import tech.jhipster.web.util.reactive.ResponseUtil;

/**
 * REST controller for managing {@link com.diviso.habittrackbackend.domain.HabitTracker}.
 */
@RestController
@RequestMapping("/api/habit-trackers")
@Transactional
public class HabitTrackerResource {

    private static final Logger LOG = LoggerFactory.getLogger(HabitTrackerResource.class);

    private final HabitTrackerRepository habitTrackerRepository;

    public HabitTrackerResource(HabitTrackerRepository habitTrackerRepository) {
        this.habitTrackerRepository = habitTrackerRepository;
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
}
