package com.diviso.dailyjournal.web.rest;

import com.diviso.dailyjournal.domain.DailyJournal;
import com.diviso.dailyjournal.repository.DailyJournalRepository;
import com.diviso.dailyjournal.web.rest.errors.BadRequestAlertException;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
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
 * REST controller for managing {@link com.diviso.dailyjournal.domain.DailyJournal}.
 */
@RestController
@RequestMapping("/api/daily-journals")
@Transactional
public class DailyJournalResource {

    private final Logger log = LoggerFactory.getLogger(DailyJournalResource.class);

    private static final String ENTITY_NAME = "dailyJournal";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final DailyJournalRepository dailyJournalRepository;

    public DailyJournalResource(DailyJournalRepository dailyJournalRepository) {
        this.dailyJournalRepository = dailyJournalRepository;
    }

    /**
     * {@code POST  /daily-journals} : Create a new dailyJournal.
     *
     * @param dailyJournal the dailyJournal to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new dailyJournal, or with status {@code 400 (Bad Request)} if the dailyJournal has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public Mono<ResponseEntity<DailyJournal>> createDailyJournal(@Valid @RequestBody DailyJournal dailyJournal) throws URISyntaxException {
        log.debug("REST request to save DailyJournal : {}", dailyJournal);
        if (dailyJournal.getId() != null) {
            throw new BadRequestAlertException("A new dailyJournal cannot already have an ID", ENTITY_NAME, "idexists");
        }
        return dailyJournalRepository
            .save(dailyJournal)
            .map(result -> {
                try {
                    return ResponseEntity
                        .created(new URI("/api/daily-journals/" + result.getId()))
                        .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
                        .body(result);
                } catch (URISyntaxException e) {
                    throw new RuntimeException(e);
                }
            });
    }

    /**
     * {@code PUT  /daily-journals/:id} : Updates an existing dailyJournal.
     *
     * @param id the id of the dailyJournal to save.
     * @param dailyJournal the dailyJournal to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated dailyJournal,
     * or with status {@code 400 (Bad Request)} if the dailyJournal is not valid,
     * or with status {@code 500 (Internal Server Error)} if the dailyJournal couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public Mono<ResponseEntity<DailyJournal>> updateDailyJournal(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody DailyJournal dailyJournal
    ) throws URISyntaxException {
        log.debug("REST request to update DailyJournal : {}, {}", id, dailyJournal);
        if (dailyJournal.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, dailyJournal.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        return dailyJournalRepository
            .existsById(id)
            .flatMap(exists -> {
                if (!exists) {
                    return Mono.error(new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound"));
                }

                return dailyJournalRepository
                    .save(dailyJournal)
                    .switchIfEmpty(Mono.error(new ResponseStatusException(HttpStatus.NOT_FOUND)))
                    .map(result ->
                        ResponseEntity
                            .ok()
                            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
                            .body(result)
                    );
            });
    }

    /**
     * {@code PATCH  /daily-journals/:id} : Partial updates given fields of an existing dailyJournal, field will ignore if it is null
     *
     * @param id the id of the dailyJournal to save.
     * @param dailyJournal the dailyJournal to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated dailyJournal,
     * or with status {@code 400 (Bad Request)} if the dailyJournal is not valid,
     * or with status {@code 404 (Not Found)} if the dailyJournal is not found,
     * or with status {@code 500 (Internal Server Error)} if the dailyJournal couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public Mono<ResponseEntity<DailyJournal>> partialUpdateDailyJournal(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody DailyJournal dailyJournal
    ) throws URISyntaxException {
        log.debug("REST request to partial update DailyJournal partially : {}, {}", id, dailyJournal);
        if (dailyJournal.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, dailyJournal.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        return dailyJournalRepository
            .existsById(id)
            .flatMap(exists -> {
                if (!exists) {
                    return Mono.error(new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound"));
                }

                Mono<DailyJournal> result = dailyJournalRepository
                    .findById(dailyJournal.getId())
                    .map(existingDailyJournal -> {
                        if (dailyJournal.getTitle() != null) {
                            existingDailyJournal.setTitle(dailyJournal.getTitle());
                        }
                        if (dailyJournal.getContent() != null) {
                            existingDailyJournal.setContent(dailyJournal.getContent());
                        }
                        if (dailyJournal.getDate() != null) {
                            existingDailyJournal.setDate(dailyJournal.getDate());
                        }

                        return existingDailyJournal;
                    })
                    .flatMap(dailyJournalRepository::save);

                return result
                    .switchIfEmpty(Mono.error(new ResponseStatusException(HttpStatus.NOT_FOUND)))
                    .map(res ->
                        ResponseEntity
                            .ok()
                            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, res.getId().toString()))
                            .body(res)
                    );
            });
    }

    /**
     * {@code GET  /daily-journals} : get all the dailyJournals.
     *
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of dailyJournals in body.
     */
    @GetMapping(value = "", produces = MediaType.APPLICATION_JSON_VALUE)
    public Mono<List<DailyJournal>> getAllDailyJournals() {
        log.debug("REST request to get all DailyJournals");
        return dailyJournalRepository.findAll().collectList();
    }

    /**
     * {@code GET  /daily-journals} : get all the dailyJournals as a stream.
     * @return the {@link Flux} of dailyJournals.
     */
    @GetMapping(value = "", produces = MediaType.APPLICATION_NDJSON_VALUE)
    public Flux<DailyJournal> getAllDailyJournalsAsStream() {
        log.debug("REST request to get all DailyJournals as a stream");
        return dailyJournalRepository.findAll();
    }

    /**
     * {@code GET  /daily-journals/:id} : get the "id" dailyJournal.
     *
     * @param id the id of the dailyJournal to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the dailyJournal, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public Mono<ResponseEntity<DailyJournal>> getDailyJournal(@PathVariable("id") Long id) {
        log.debug("REST request to get DailyJournal : {}", id);
        Mono<DailyJournal> dailyJournal = dailyJournalRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(dailyJournal);
    }

    /**
     * {@code DELETE  /daily-journals/:id} : delete the "id" dailyJournal.
     *
     * @param id the id of the dailyJournal to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public Mono<ResponseEntity<Void>> deleteDailyJournal(@PathVariable("id") Long id) {
        log.debug("REST request to delete DailyJournal : {}", id);
        return dailyJournalRepository
            .deleteById(id)
            .then(
                Mono.just(
                    ResponseEntity
                        .noContent()
                        .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
                        .build()
                )
            );
    }
}
