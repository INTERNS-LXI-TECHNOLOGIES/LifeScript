package com.divisosoft.web.rest;

import com.divisosoft.domain.PomodoroBreak;
import com.divisosoft.repository.PomodoroBreakRepository;
import com.divisosoft.web.rest.errors.BadRequestAlertException;
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
 * REST controller for managing {@link com.divisosoft.domain.PomodoroBreak}.
 */
@RestController
@RequestMapping("/api/pomodoro-breaks")
@Transactional
public class PomodoroBreakResource {

    private static final Logger LOG = LoggerFactory.getLogger(PomodoroBreakResource.class);

    private static final String ENTITY_NAME = "pomodoroBreak";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final PomodoroBreakRepository pomodoroBreakRepository;

    public PomodoroBreakResource(PomodoroBreakRepository pomodoroBreakRepository) {
        this.pomodoroBreakRepository = pomodoroBreakRepository;
    }

    /**
     * {@code POST  /pomodoro-breaks} : Create a new pomodoroBreak.
     *
     * @param pomodoroBreak the pomodoroBreak to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new pomodoroBreak, or with status {@code 400 (Bad Request)} if the pomodoroBreak has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public Mono<ResponseEntity<PomodoroBreak>> createPomodoroBreak(@RequestBody PomodoroBreak pomodoroBreak) throws URISyntaxException {
        LOG.debug("REST request to save PomodoroBreak : {}", pomodoroBreak);
        if (pomodoroBreak.getId() != null) {
            throw new BadRequestAlertException("A new pomodoroBreak cannot already have an ID", ENTITY_NAME, "idexists");
        }
        return pomodoroBreakRepository
            .save(pomodoroBreak)
            .map(result -> {
                try {
                    return ResponseEntity.created(new URI("/api/pomodoro-breaks/" + result.getId()))
                        .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
                        .body(result);
                } catch (URISyntaxException e) {
                    throw new RuntimeException(e);
                }
            });
    }

    /**
     * {@code PUT  /pomodoro-breaks/:id} : Updates an existing pomodoroBreak.
     *
     * @param id the id of the pomodoroBreak to save.
     * @param pomodoroBreak the pomodoroBreak to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated pomodoroBreak,
     * or with status {@code 400 (Bad Request)} if the pomodoroBreak is not valid,
     * or with status {@code 500 (Internal Server Error)} if the pomodoroBreak couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public Mono<ResponseEntity<PomodoroBreak>> updatePomodoroBreak(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody PomodoroBreak pomodoroBreak
    ) throws URISyntaxException {
        LOG.debug("REST request to update PomodoroBreak : {}, {}", id, pomodoroBreak);
        if (pomodoroBreak.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, pomodoroBreak.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        return pomodoroBreakRepository
            .existsById(id)
            .flatMap(exists -> {
                if (!exists) {
                    return Mono.error(new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound"));
                }

                return pomodoroBreakRepository
                    .save(pomodoroBreak)
                    .switchIfEmpty(Mono.error(new ResponseStatusException(HttpStatus.NOT_FOUND)))
                    .map(result ->
                        ResponseEntity.ok()
                            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
                            .body(result)
                    );
            });
    }

    /**
     * {@code PATCH  /pomodoro-breaks/:id} : Partial updates given fields of an existing pomodoroBreak, field will ignore if it is null
     *
     * @param id the id of the pomodoroBreak to save.
     * @param pomodoroBreak the pomodoroBreak to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated pomodoroBreak,
     * or with status {@code 400 (Bad Request)} if the pomodoroBreak is not valid,
     * or with status {@code 404 (Not Found)} if the pomodoroBreak is not found,
     * or with status {@code 500 (Internal Server Error)} if the pomodoroBreak couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public Mono<ResponseEntity<PomodoroBreak>> partialUpdatePomodoroBreak(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody PomodoroBreak pomodoroBreak
    ) throws URISyntaxException {
        LOG.debug("REST request to partial update PomodoroBreak partially : {}, {}", id, pomodoroBreak);
        if (pomodoroBreak.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, pomodoroBreak.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        return pomodoroBreakRepository
            .existsById(id)
            .flatMap(exists -> {
                if (!exists) {
                    return Mono.error(new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound"));
                }

                Mono<PomodoroBreak> result = pomodoroBreakRepository
                    .findById(pomodoroBreak.getId())
                    .map(existingPomodoroBreak -> {
                        if (pomodoroBreak.getTotalWorkingHour() != null) {
                            existingPomodoroBreak.setTotalWorkingHour(pomodoroBreak.getTotalWorkingHour());
                        }
                        if (pomodoroBreak.getDailyDurationOfWork() != null) {
                            existingPomodoroBreak.setDailyDurationOfWork(pomodoroBreak.getDailyDurationOfWork());
                        }
                        if (pomodoroBreak.getSplitBreakDuration() != null) {
                            existingPomodoroBreak.setSplitBreakDuration(pomodoroBreak.getSplitBreakDuration());
                        }
                        if (pomodoroBreak.getBreakDuration() != null) {
                            existingPomodoroBreak.setBreakDuration(pomodoroBreak.getBreakDuration());
                        }
                        if (pomodoroBreak.getCompletedBreaks() != null) {
                            existingPomodoroBreak.setCompletedBreaks(pomodoroBreak.getCompletedBreaks());
                        }
                        if (pomodoroBreak.getDateOfPomodoro() != null) {
                            existingPomodoroBreak.setDateOfPomodoro(pomodoroBreak.getDateOfPomodoro());
                        }
                        if (pomodoroBreak.getTimeOfPomodoroCreation() != null) {
                            existingPomodoroBreak.setTimeOfPomodoroCreation(pomodoroBreak.getTimeOfPomodoroCreation());
                        }
                        if (pomodoroBreak.getNotificationForBreak() != null) {
                            existingPomodoroBreak.setNotificationForBreak(pomodoroBreak.getNotificationForBreak());
                        }
                        if (pomodoroBreak.getFinalMessage() != null) {
                            existingPomodoroBreak.setFinalMessage(pomodoroBreak.getFinalMessage());
                        }

                        return existingPomodoroBreak;
                    })
                    .flatMap(pomodoroBreakRepository::save);

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
     * {@code GET  /pomodoro-breaks} : get all the pomodoroBreaks.
     *
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of pomodoroBreaks in body.
     */
    @GetMapping(value = "", produces = MediaType.APPLICATION_JSON_VALUE)
    public Mono<List<PomodoroBreak>> getAllPomodoroBreaks() {
        LOG.debug("REST request to get all PomodoroBreaks");
        return pomodoroBreakRepository.findAll().collectList();
    }

    /**
     * {@code GET  /pomodoro-breaks} : get all the pomodoroBreaks as a stream.
     * @return the {@link Flux} of pomodoroBreaks.
     */
    @GetMapping(value = "", produces = MediaType.APPLICATION_NDJSON_VALUE)
    public Flux<PomodoroBreak> getAllPomodoroBreaksAsStream() {
        LOG.debug("REST request to get all PomodoroBreaks as a stream");
        return pomodoroBreakRepository.findAll();
    }

    /**
     * {@code GET  /pomodoro-breaks/:id} : get the "id" pomodoroBreak.
     *
     * @param id the id of the pomodoroBreak to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the pomodoroBreak, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public Mono<ResponseEntity<PomodoroBreak>> getPomodoroBreak(@PathVariable("id") Long id) {
        LOG.debug("REST request to get PomodoroBreak : {}", id);
        Mono<PomodoroBreak> pomodoroBreak = pomodoroBreakRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(pomodoroBreak);
    }

    /**
     * {@code DELETE  /pomodoro-breaks/:id} : delete the "id" pomodoroBreak.
     *
     * @param id the id of the pomodoroBreak to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public Mono<ResponseEntity<Void>> deletePomodoroBreak(@PathVariable("id") Long id) {
        LOG.debug("REST request to delete PomodoroBreak : {}", id);
        return pomodoroBreakRepository
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
