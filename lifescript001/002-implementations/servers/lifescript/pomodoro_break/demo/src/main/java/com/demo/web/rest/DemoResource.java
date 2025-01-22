package com.demo.web.rest;

import com.demo.domain.Demo;
import com.demo.repository.DemoRepository;
import com.demo.web.rest.errors.BadRequestAlertException;
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
 * REST controller for managing {@link com.demo.domain.Demo}.
 */
@RestController
@RequestMapping("/api/demos")
@Transactional
public class DemoResource {

    private static final Logger LOG = LoggerFactory.getLogger(DemoResource.class);

    private static final String ENTITY_NAME = "demo";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final DemoRepository demoRepository;

    public DemoResource(DemoRepository demoRepository) {
        this.demoRepository = demoRepository;
    }

    /**
     * {@code POST  /demos} : Create a new demo.
     *
     * @param demo the demo to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new demo, or with status {@code 400 (Bad Request)} if the demo has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public Mono<ResponseEntity<Demo>> createDemo(@RequestBody Demo demo) throws URISyntaxException {
        LOG.debug("REST request to save Demo : {}", demo);
        if (demo.getId() != null) {
            throw new BadRequestAlertException("A new demo cannot already have an ID", ENTITY_NAME, "idexists");
        }
        return demoRepository
            .save(demo)
            .map(result -> {
                try {
                    return ResponseEntity.created(new URI("/api/demos/" + result.getId()))
                        .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
                        .body(result);
                } catch (URISyntaxException e) {
                    throw new RuntimeException(e);
                }
            });
    }

    /**
     * {@code PUT  /demos/:id} : Updates an existing demo.
     *
     * @param id the id of the demo to save.
     * @param demo the demo to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated demo,
     * or with status {@code 400 (Bad Request)} if the demo is not valid,
     * or with status {@code 500 (Internal Server Error)} if the demo couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public Mono<ResponseEntity<Demo>> updateDemo(@PathVariable(value = "id", required = false) final Long id, @RequestBody Demo demo)
        throws URISyntaxException {
        LOG.debug("REST request to update Demo : {}, {}", id, demo);
        if (demo.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, demo.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        return demoRepository
            .existsById(id)
            .flatMap(exists -> {
                if (!exists) {
                    return Mono.error(new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound"));
                }

                return demoRepository
                    .save(demo)
                    .switchIfEmpty(Mono.error(new ResponseStatusException(HttpStatus.NOT_FOUND)))
                    .map(result ->
                        ResponseEntity.ok()
                            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
                            .body(result)
                    );
            });
    }

    /**
     * {@code PATCH  /demos/:id} : Partial updates given fields of an existing demo, field will ignore if it is null
     *
     * @param id the id of the demo to save.
     * @param demo the demo to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated demo,
     * or with status {@code 400 (Bad Request)} if the demo is not valid,
     * or with status {@code 404 (Not Found)} if the demo is not found,
     * or with status {@code 500 (Internal Server Error)} if the demo couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public Mono<ResponseEntity<Demo>> partialUpdateDemo(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody Demo demo
    ) throws URISyntaxException {
        LOG.debug("REST request to partial update Demo partially : {}, {}", id, demo);
        if (demo.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, demo.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        return demoRepository
            .existsById(id)
            .flatMap(exists -> {
                if (!exists) {
                    return Mono.error(new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound"));
                }

                Mono<Demo> result = demoRepository
                    .findById(demo.getId())
                    .map(existingDemo -> {
                        if (demo.getUsername() != null) {
                            existingDemo.setUsername(demo.getUsername());
                        }
                        if (demo.getMobileNumber() != null) {
                            existingDemo.setMobileNumber(demo.getMobileNumber());
                        }

                        return existingDemo;
                    })
                    .flatMap(demoRepository::save);

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
     * {@code GET  /demos} : get all the demos.
     *
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of demos in body.
     */
    @GetMapping(value = "", produces = MediaType.APPLICATION_JSON_VALUE)
    public Mono<List<Demo>> getAllDemos() {
        LOG.debug("REST request to get all Demos");
        return demoRepository.findAll().collectList();
    }

    /**
     * {@code GET  /demos} : get all the demos as a stream.
     * @return the {@link Flux} of demos.
     */
    @GetMapping(value = "", produces = MediaType.APPLICATION_NDJSON_VALUE)
    public Flux<Demo> getAllDemosAsStream() {
        LOG.debug("REST request to get all Demos as a stream");
        return demoRepository.findAll();
    }

    /**
     * {@code GET  /demos/:id} : get the "id" demo.
     *
     * @param id the id of the demo to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the demo, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public Mono<ResponseEntity<Demo>> getDemo(@PathVariable("id") Long id) {
        LOG.debug("REST request to get Demo : {}", id);
        Mono<Demo> demo = demoRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(demo);
    }

    /**
     * {@code DELETE  /demos/:id} : delete the "id" demo.
     *
     * @param id the id of the demo to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public Mono<ResponseEntity<Void>> deleteDemo(@PathVariable("id") Long id) {
        LOG.debug("REST request to delete Demo : {}", id);
        return demoRepository
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
