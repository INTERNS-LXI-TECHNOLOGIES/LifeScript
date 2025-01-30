package com.diviso.web.rest;

import com.diviso.domain.MediaContent;
import com.diviso.repository.MediaContentRepository;
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
 * REST controller for managing {@link com.diviso.domain.MediaContent}.
 */
@RestController
@RequestMapping("/api/media-contents")
@Transactional
public class MediaContentResource {

    private static final Logger LOG = LoggerFactory.getLogger(MediaContentResource.class);

    private static final String ENTITY_NAME = "mediaContent";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final MediaContentRepository mediaContentRepository;

    public MediaContentResource(MediaContentRepository mediaContentRepository) {
        this.mediaContentRepository = mediaContentRepository;
    }

    /**
     * {@code POST  /media-contents} : Create a new mediaContent.
     *
     * @param mediaContent the mediaContent to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new mediaContent, or with status {@code 400 (Bad Request)} if the mediaContent has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<MediaContent> createMediaContent(@Valid @RequestBody MediaContent mediaContent) throws URISyntaxException {
        LOG.debug("REST request to save MediaContent : {}", mediaContent);
        if (mediaContent.getId() != null) {
            throw new BadRequestAlertException("A new mediaContent cannot already have an ID", ENTITY_NAME, "idexists");
        }
        mediaContent = mediaContentRepository.save(mediaContent);
        return ResponseEntity.created(new URI("/api/media-contents/" + mediaContent.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, mediaContent.getId().toString()))
            .body(mediaContent);
    }

    /**
     * {@code PUT  /media-contents/:id} : Updates an existing mediaContent.
     *
     * @param id the id of the mediaContent to save.
     * @param mediaContent the mediaContent to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated mediaContent,
     * or with status {@code 400 (Bad Request)} if the mediaContent is not valid,
     * or with status {@code 500 (Internal Server Error)} if the mediaContent couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<MediaContent> updateMediaContent(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody MediaContent mediaContent
    ) throws URISyntaxException {
        LOG.debug("REST request to update MediaContent : {}, {}", id, mediaContent);
        if (mediaContent.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, mediaContent.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!mediaContentRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        mediaContent = mediaContentRepository.save(mediaContent);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, mediaContent.getId().toString()))
            .body(mediaContent);
    }

    /**
     * {@code PATCH  /media-contents/:id} : Partial updates given fields of an existing mediaContent, field will ignore if it is null
     *
     * @param id the id of the mediaContent to save.
     * @param mediaContent the mediaContent to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated mediaContent,
     * or with status {@code 400 (Bad Request)} if the mediaContent is not valid,
     * or with status {@code 404 (Not Found)} if the mediaContent is not found,
     * or with status {@code 500 (Internal Server Error)} if the mediaContent couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<MediaContent> partialUpdateMediaContent(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody MediaContent mediaContent
    ) throws URISyntaxException {
        LOG.debug("REST request to partial update MediaContent partially : {}, {}", id, mediaContent);
        if (mediaContent.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, mediaContent.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!mediaContentRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<MediaContent> result = mediaContentRepository
            .findById(mediaContent.getId())
            .map(existingMediaContent -> {
                if (mediaContent.getText() != null) {
                    existingMediaContent.setText(mediaContent.getText());
                }
                if (mediaContent.getAudio() != null) {
                    existingMediaContent.setAudio(mediaContent.getAudio());
                }
                if (mediaContent.getAudioContentType() != null) {
                    existingMediaContent.setAudioContentType(mediaContent.getAudioContentType());
                }
                if (mediaContent.getUploadDateTime() != null) {
                    existingMediaContent.setUploadDateTime(mediaContent.getUploadDateTime());
                }
                if (mediaContent.getLanguage() != null) {
                    existingMediaContent.setLanguage(mediaContent.getLanguage());
                }
                if (mediaContent.getDifficultyLevel() != null) {
                    existingMediaContent.setDifficultyLevel(mediaContent.getDifficultyLevel());
                }

                return existingMediaContent;
            })
            .map(mediaContentRepository::save);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, mediaContent.getId().toString())
        );
    }

    /**
     * {@code GET  /media-contents} : get all the mediaContents.
     *
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of mediaContents in body.
     */
    @GetMapping("")
    public List<MediaContent> getAllMediaContents() {
        LOG.debug("REST request to get all MediaContents");
        return mediaContentRepository.findAll();
    }

    /**
     * {@code GET  /media-contents/:id} : get the "id" mediaContent.
     *
     * @param id the id of the mediaContent to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the mediaContent, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<MediaContent> getMediaContent(@PathVariable("id") Long id) {
        LOG.debug("REST request to get MediaContent : {}", id);
        Optional<MediaContent> mediaContent = mediaContentRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(mediaContent);
    }

    /**
     * {@code DELETE  /media-contents/:id} : delete the "id" mediaContent.
     *
     * @param id the id of the mediaContent to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMediaContent(@PathVariable("id") Long id) {
        LOG.debug("REST request to delete MediaContent : {}", id);
        mediaContentRepository.deleteById(id);
        return ResponseEntity.noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}
