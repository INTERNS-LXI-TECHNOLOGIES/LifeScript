package com.diviso.web.rest;

import static com.diviso.domain.MediaContentAsserts.*;
import static com.diviso.web.rest.TestUtil.createUpdateProxyForBean;
import static com.diviso.web.rest.TestUtil.sameInstant;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.diviso.IntegrationTest;
import com.diviso.domain.MediaContent;
import com.diviso.repository.MediaContentRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.EntityManager;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.util.Base64;
import java.util.Random;
import java.util.concurrent.atomic.AtomicLong;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

/**
 * Integration tests for the {@link MediaContentResource} REST controller.
 */
@IntegrationTest
@AutoConfigureMockMvc
@WithMockUser
class MediaContentResourceIT {

    private static final String DEFAULT_TEXT = "AAAAAAAAAA";
    private static final String UPDATED_TEXT = "BBBBBBBBBB";

    private static final byte[] DEFAULT_AUDIO = TestUtil.createByteArray(1, "0");
    private static final byte[] UPDATED_AUDIO = TestUtil.createByteArray(1, "1");
    private static final String DEFAULT_AUDIO_CONTENT_TYPE = "image/jpg";
    private static final String UPDATED_AUDIO_CONTENT_TYPE = "image/png";

    private static final ZonedDateTime DEFAULT_UPLOAD_DATE_TIME = ZonedDateTime.ofInstant(Instant.ofEpochMilli(0L), ZoneOffset.UTC);
    private static final ZonedDateTime UPDATED_UPLOAD_DATE_TIME = ZonedDateTime.now(ZoneId.systemDefault()).withNano(0);

    private static final String DEFAULT_LANGUAGE = "AAAAAAAAAA";
    private static final String UPDATED_LANGUAGE = "BBBBBBBBBB";

    private static final Integer DEFAULT_DIFFICULTY_LEVEL = 1;
    private static final Integer UPDATED_DIFFICULTY_LEVEL = 2;

    private static final String ENTITY_API_URL = "/api/media-contents";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private ObjectMapper om;

    @Autowired
    private MediaContentRepository mediaContentRepository;

    @Autowired
    private EntityManager em;

    @Autowired
    private MockMvc restMediaContentMockMvc;

    private MediaContent mediaContent;

    private MediaContent insertedMediaContent;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static MediaContent createEntity() {
        return new MediaContent()
            .text(DEFAULT_TEXT)
            .audio(DEFAULT_AUDIO)
            .audioContentType(DEFAULT_AUDIO_CONTENT_TYPE)
            .uploadDateTime(DEFAULT_UPLOAD_DATE_TIME)
            .language(DEFAULT_LANGUAGE)
            .difficultyLevel(DEFAULT_DIFFICULTY_LEVEL);
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static MediaContent createUpdatedEntity() {
        return new MediaContent()
            .text(UPDATED_TEXT)
            .audio(UPDATED_AUDIO)
            .audioContentType(UPDATED_AUDIO_CONTENT_TYPE)
            .uploadDateTime(UPDATED_UPLOAD_DATE_TIME)
            .language(UPDATED_LANGUAGE)
            .difficultyLevel(UPDATED_DIFFICULTY_LEVEL);
    }

    @BeforeEach
    public void initTest() {
        mediaContent = createEntity();
    }

    @AfterEach
    public void cleanup() {
        if (insertedMediaContent != null) {
            mediaContentRepository.delete(insertedMediaContent);
            insertedMediaContent = null;
        }
    }

    @Test
    @Transactional
    void createMediaContent() throws Exception {
        long databaseSizeBeforeCreate = getRepositoryCount();
        // Create the MediaContent
        var returnedMediaContent = om.readValue(
            restMediaContentMockMvc
                .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(mediaContent)))
                .andExpect(status().isCreated())
                .andReturn()
                .getResponse()
                .getContentAsString(),
            MediaContent.class
        );

        // Validate the MediaContent in the database
        assertIncrementedRepositoryCount(databaseSizeBeforeCreate);
        assertMediaContentUpdatableFieldsEquals(returnedMediaContent, getPersistedMediaContent(returnedMediaContent));

        insertedMediaContent = returnedMediaContent;
    }

    @Test
    @Transactional
    void createMediaContentWithExistingId() throws Exception {
        // Create the MediaContent with an existing ID
        mediaContent.setId(1L);

        long databaseSizeBeforeCreate = getRepositoryCount();

        // An entity with an existing ID cannot be created, so this API call must fail
        restMediaContentMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(mediaContent)))
            .andExpect(status().isBadRequest());

        // Validate the MediaContent in the database
        assertSameRepositoryCount(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    void checkLanguageIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        mediaContent.setLanguage(null);

        // Create the MediaContent, which fails.

        restMediaContentMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(mediaContent)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void checkDifficultyLevelIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        mediaContent.setDifficultyLevel(null);

        // Create the MediaContent, which fails.

        restMediaContentMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(mediaContent)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void getAllMediaContents() throws Exception {
        // Initialize the database
        insertedMediaContent = mediaContentRepository.saveAndFlush(mediaContent);

        // Get all the mediaContentList
        restMediaContentMockMvc
            .perform(get(ENTITY_API_URL + "?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(mediaContent.getId().intValue())))
            .andExpect(jsonPath("$.[*].text").value(hasItem(DEFAULT_TEXT)))
            .andExpect(jsonPath("$.[*].audioContentType").value(hasItem(DEFAULT_AUDIO_CONTENT_TYPE)))
            .andExpect(jsonPath("$.[*].audio").value(hasItem(Base64.getEncoder().encodeToString(DEFAULT_AUDIO))))
            .andExpect(jsonPath("$.[*].uploadDateTime").value(hasItem(sameInstant(DEFAULT_UPLOAD_DATE_TIME))))
            .andExpect(jsonPath("$.[*].language").value(hasItem(DEFAULT_LANGUAGE)))
            .andExpect(jsonPath("$.[*].difficultyLevel").value(hasItem(DEFAULT_DIFFICULTY_LEVEL)));
    }

    @Test
    @Transactional
    void getMediaContent() throws Exception {
        // Initialize the database
        insertedMediaContent = mediaContentRepository.saveAndFlush(mediaContent);

        // Get the mediaContent
        restMediaContentMockMvc
            .perform(get(ENTITY_API_URL_ID, mediaContent.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.id").value(mediaContent.getId().intValue()))
            .andExpect(jsonPath("$.text").value(DEFAULT_TEXT))
            .andExpect(jsonPath("$.audioContentType").value(DEFAULT_AUDIO_CONTENT_TYPE))
            .andExpect(jsonPath("$.audio").value(Base64.getEncoder().encodeToString(DEFAULT_AUDIO)))
            .andExpect(jsonPath("$.uploadDateTime").value(sameInstant(DEFAULT_UPLOAD_DATE_TIME)))
            .andExpect(jsonPath("$.language").value(DEFAULT_LANGUAGE))
            .andExpect(jsonPath("$.difficultyLevel").value(DEFAULT_DIFFICULTY_LEVEL));
    }

    @Test
    @Transactional
    void getNonExistingMediaContent() throws Exception {
        // Get the mediaContent
        restMediaContentMockMvc.perform(get(ENTITY_API_URL_ID, Long.MAX_VALUE)).andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    void putExistingMediaContent() throws Exception {
        // Initialize the database
        insertedMediaContent = mediaContentRepository.saveAndFlush(mediaContent);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the mediaContent
        MediaContent updatedMediaContent = mediaContentRepository.findById(mediaContent.getId()).orElseThrow();
        // Disconnect from session so that the updates on updatedMediaContent are not directly saved in db
        em.detach(updatedMediaContent);
        updatedMediaContent
            .text(UPDATED_TEXT)
            .audio(UPDATED_AUDIO)
            .audioContentType(UPDATED_AUDIO_CONTENT_TYPE)
            .uploadDateTime(UPDATED_UPLOAD_DATE_TIME)
            .language(UPDATED_LANGUAGE)
            .difficultyLevel(UPDATED_DIFFICULTY_LEVEL);

        restMediaContentMockMvc
            .perform(
                put(ENTITY_API_URL_ID, updatedMediaContent.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(updatedMediaContent))
            )
            .andExpect(status().isOk());

        // Validate the MediaContent in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPersistedMediaContentToMatchAllProperties(updatedMediaContent);
    }

    @Test
    @Transactional
    void putNonExistingMediaContent() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        mediaContent.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restMediaContentMockMvc
            .perform(
                put(ENTITY_API_URL_ID, mediaContent.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(mediaContent))
            )
            .andExpect(status().isBadRequest());

        // Validate the MediaContent in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithIdMismatchMediaContent() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        mediaContent.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restMediaContentMockMvc
            .perform(
                put(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(mediaContent))
            )
            .andExpect(status().isBadRequest());

        // Validate the MediaContent in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithMissingIdPathParamMediaContent() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        mediaContent.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restMediaContentMockMvc
            .perform(put(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(mediaContent)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the MediaContent in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void partialUpdateMediaContentWithPatch() throws Exception {
        // Initialize the database
        insertedMediaContent = mediaContentRepository.saveAndFlush(mediaContent);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the mediaContent using partial update
        MediaContent partialUpdatedMediaContent = new MediaContent();
        partialUpdatedMediaContent.setId(mediaContent.getId());

        partialUpdatedMediaContent
            .audio(UPDATED_AUDIO)
            .audioContentType(UPDATED_AUDIO_CONTENT_TYPE)
            .uploadDateTime(UPDATED_UPLOAD_DATE_TIME)
            .difficultyLevel(UPDATED_DIFFICULTY_LEVEL);

        restMediaContentMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedMediaContent.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedMediaContent))
            )
            .andExpect(status().isOk());

        // Validate the MediaContent in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertMediaContentUpdatableFieldsEquals(
            createUpdateProxyForBean(partialUpdatedMediaContent, mediaContent),
            getPersistedMediaContent(mediaContent)
        );
    }

    @Test
    @Transactional
    void fullUpdateMediaContentWithPatch() throws Exception {
        // Initialize the database
        insertedMediaContent = mediaContentRepository.saveAndFlush(mediaContent);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the mediaContent using partial update
        MediaContent partialUpdatedMediaContent = new MediaContent();
        partialUpdatedMediaContent.setId(mediaContent.getId());

        partialUpdatedMediaContent
            .text(UPDATED_TEXT)
            .audio(UPDATED_AUDIO)
            .audioContentType(UPDATED_AUDIO_CONTENT_TYPE)
            .uploadDateTime(UPDATED_UPLOAD_DATE_TIME)
            .language(UPDATED_LANGUAGE)
            .difficultyLevel(UPDATED_DIFFICULTY_LEVEL);

        restMediaContentMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedMediaContent.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedMediaContent))
            )
            .andExpect(status().isOk());

        // Validate the MediaContent in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertMediaContentUpdatableFieldsEquals(partialUpdatedMediaContent, getPersistedMediaContent(partialUpdatedMediaContent));
    }

    @Test
    @Transactional
    void patchNonExistingMediaContent() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        mediaContent.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restMediaContentMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, mediaContent.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(mediaContent))
            )
            .andExpect(status().isBadRequest());

        // Validate the MediaContent in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithIdMismatchMediaContent() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        mediaContent.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restMediaContentMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(mediaContent))
            )
            .andExpect(status().isBadRequest());

        // Validate the MediaContent in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithMissingIdPathParamMediaContent() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        mediaContent.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restMediaContentMockMvc
            .perform(patch(ENTITY_API_URL).contentType("application/merge-patch+json").content(om.writeValueAsBytes(mediaContent)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the MediaContent in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void deleteMediaContent() throws Exception {
        // Initialize the database
        insertedMediaContent = mediaContentRepository.saveAndFlush(mediaContent);

        long databaseSizeBeforeDelete = getRepositoryCount();

        // Delete the mediaContent
        restMediaContentMockMvc
            .perform(delete(ENTITY_API_URL_ID, mediaContent.getId()).accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isNoContent());

        // Validate the database contains one less item
        assertDecrementedRepositoryCount(databaseSizeBeforeDelete);
    }

    protected long getRepositoryCount() {
        return mediaContentRepository.count();
    }

    protected void assertIncrementedRepositoryCount(long countBefore) {
        assertThat(countBefore + 1).isEqualTo(getRepositoryCount());
    }

    protected void assertDecrementedRepositoryCount(long countBefore) {
        assertThat(countBefore - 1).isEqualTo(getRepositoryCount());
    }

    protected void assertSameRepositoryCount(long countBefore) {
        assertThat(countBefore).isEqualTo(getRepositoryCount());
    }

    protected MediaContent getPersistedMediaContent(MediaContent mediaContent) {
        return mediaContentRepository.findById(mediaContent.getId()).orElseThrow();
    }

    protected void assertPersistedMediaContentToMatchAllProperties(MediaContent expectedMediaContent) {
        assertMediaContentAllPropertiesEquals(expectedMediaContent, getPersistedMediaContent(expectedMediaContent));
    }

    protected void assertPersistedMediaContentToMatchUpdatableProperties(MediaContent expectedMediaContent) {
        assertMediaContentAllUpdatablePropertiesEquals(expectedMediaContent, getPersistedMediaContent(expectedMediaContent));
    }
}
