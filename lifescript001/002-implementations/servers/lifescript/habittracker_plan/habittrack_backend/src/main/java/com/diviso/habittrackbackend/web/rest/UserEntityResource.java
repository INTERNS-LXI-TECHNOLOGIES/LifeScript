package com.diviso.habittrackbackend.web.rest;

import com.diviso.habittrackbackend.domain.UserEntity;
import com.diviso.habittrackbackend.repository.UserEntityRepository;
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
 * REST controller for managing {@link com.diviso.habittrackbackend.domain.UserEntity}.
 */
@RestController
@RequestMapping("/api/user-entities")
@Transactional
public class UserEntityResource {

    private static final Logger LOG = LoggerFactory.getLogger(UserEntityResource.class);

    private static final String ENTITY_NAME = "userEntity";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final UserEntityRepository userEntityRepository;

    public UserEntityResource(UserEntityRepository userEntityRepository) {
        this.userEntityRepository = userEntityRepository;
    }

    /**
     * {@code POST  /user-entities} : Create a new userEntity.
     *
     * @param userEntity the userEntity to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new userEntity, or with status {@code 400 (Bad Request)} if the userEntity has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public Mono<ResponseEntity<UserEntity>> createUserEntity(@RequestBody UserEntity userEntity) throws URISyntaxException {
        LOG.debug("REST request to save UserEntity : {}", userEntity);
        if (userEntity.getId() != null) {
            throw new BadRequestAlertException("A new userEntity cannot already have an ID", ENTITY_NAME, "idexists");
        }
        return userEntityRepository
            .save(userEntity)
            .map(result -> {
                try {
                    return ResponseEntity.created(new URI("/api/user-entities/" + result.getId()))
                        .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
                        .body(result);
                } catch (URISyntaxException e) {
                    throw new RuntimeException(e);
                }
            });
    }

    /**
     * {@code PUT  /user-entities/:id} : Updates an existing userEntity.
     *
     * @param id the id of the userEntity to save.
     * @param userEntity the userEntity to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated userEntity,
     * or with status {@code 400 (Bad Request)} if the userEntity is not valid,
     * or with status {@code 500 (Internal Server Error)} if the userEntity couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public Mono<ResponseEntity<UserEntity>> updateUserEntity(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody UserEntity userEntity
    ) throws URISyntaxException {
        LOG.debug("REST request to update UserEntity : {}, {}", id, userEntity);
        if (userEntity.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, userEntity.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        return userEntityRepository
            .existsById(id)
            .flatMap(exists -> {
                if (!exists) {
                    return Mono.error(new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound"));
                }

                return userEntityRepository
                    .save(userEntity)
                    .switchIfEmpty(Mono.error(new ResponseStatusException(HttpStatus.NOT_FOUND)))
                    .map(result ->
                        ResponseEntity.ok()
                            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
                            .body(result)
                    );
            });
    }

    /**
     * {@code PATCH  /user-entities/:id} : Partial updates given fields of an existing userEntity, field will ignore if it is null
     *
     * @param id the id of the userEntity to save.
     * @param userEntity the userEntity to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated userEntity,
     * or with status {@code 400 (Bad Request)} if the userEntity is not valid,
     * or with status {@code 404 (Not Found)} if the userEntity is not found,
     * or with status {@code 500 (Internal Server Error)} if the userEntity couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public Mono<ResponseEntity<UserEntity>> partialUpdateUserEntity(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody UserEntity userEntity
    ) throws URISyntaxException {
        LOG.debug("REST request to partial update UserEntity partially : {}, {}", id, userEntity);
        if (userEntity.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, userEntity.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        return userEntityRepository
            .existsById(id)
            .flatMap(exists -> {
                if (!exists) {
                    return Mono.error(new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound"));
                }

                Mono<UserEntity> result = userEntityRepository
                    .findById(userEntity.getId())
                    .map(existingUserEntity -> {
                        if (userEntity.getUserId() != null) {
                            existingUserEntity.setUserId(userEntity.getUserId());
                        }
                        if (userEntity.getUserName() != null) {
                            existingUserEntity.setUserName(userEntity.getUserName());
                        }

                        return existingUserEntity;
                    })
                    .flatMap(userEntityRepository::save);

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
     * {@code GET  /user-entities} : get all the userEntities.
     *
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of userEntities in body.
     */
    @GetMapping(value = "", produces = MediaType.APPLICATION_JSON_VALUE)
    public Mono<List<UserEntity>> getAllUserEntities() {
        LOG.debug("REST request to get all UserEntities");
        return userEntityRepository.findAll().collectList();
    }

    /**
     * {@code GET  /user-entities} : get all the userEntities as a stream.
     * @return the {@link Flux} of userEntities.
     */
    @GetMapping(value = "", produces = MediaType.APPLICATION_NDJSON_VALUE)
    public Flux<UserEntity> getAllUserEntitiesAsStream() {
        LOG.debug("REST request to get all UserEntities as a stream");
        return userEntityRepository.findAll();
    }

    /**
     * {@code GET  /user-entities/:id} : get the "id" userEntity.
     *
     * @param id the id of the userEntity to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the userEntity, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public Mono<ResponseEntity<UserEntity>> getUserEntity(@PathVariable("id") Long id) {
        LOG.debug("REST request to get UserEntity : {}", id);
        Mono<UserEntity> userEntity = userEntityRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(userEntity);
    }

    /**
     * {@code DELETE  /user-entities/:id} : delete the "id" userEntity.
     *
     * @param id the id of the userEntity to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public Mono<ResponseEntity<Void>> deleteUserEntity(@PathVariable("id") Long id) {
        LOG.debug("REST request to delete UserEntity : {}", id);
        return userEntityRepository
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
