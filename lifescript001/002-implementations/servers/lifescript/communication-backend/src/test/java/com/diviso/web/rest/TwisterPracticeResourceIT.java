package com.diviso.web.rest;

import static com.diviso.domain.TwisterPracticeAsserts.*;
import static com.diviso.web.rest.TestUtil.createUpdateProxyForBean;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.diviso.IntegrationTest;
import com.diviso.domain.TwisterPractice;
import com.diviso.repository.TwisterPracticeRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.EntityManager;
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
 * Integration tests for the {@link TwisterPracticeResource} REST controller.
 */
@IntegrationTest
@AutoConfigureMockMvc
@WithMockUser
class TwisterPracticeResourceIT {

    private static final Integer DEFAULT_SCORE = 1;
    private static final Integer UPDATED_SCORE = 2;

    private static final Integer DEFAULT_TIMES_PRACTICED = 1;
    private static final Integer UPDATED_TIMES_PRACTICED = 2;

    private static final String DEFAULT_CORRECTIONS = "AAAAAAAAAA";
    private static final String UPDATED_CORRECTIONS = "BBBBBBBBBB";

    private static final String ENTITY_API_URL = "/api/twister-practices";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private ObjectMapper om;

    @Autowired
    private TwisterPracticeRepository twisterPracticeRepository;

    @Autowired
    private EntityManager em;

    @Autowired
    private MockMvc restTwisterPracticeMockMvc;

    private TwisterPractice twisterPractice;

    private TwisterPractice insertedTwisterPractice;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static TwisterPractice createEntity() {
        return new TwisterPractice().score(DEFAULT_SCORE).timesPracticed(DEFAULT_TIMES_PRACTICED).corrections(DEFAULT_CORRECTIONS);
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static TwisterPractice createUpdatedEntity() {
        return new TwisterPractice().score(UPDATED_SCORE).timesPracticed(UPDATED_TIMES_PRACTICED).corrections(UPDATED_CORRECTIONS);
    }

    @BeforeEach
    public void initTest() {
        twisterPractice = createEntity();
    }

    @AfterEach
    public void cleanup() {
        if (insertedTwisterPractice != null) {
            twisterPracticeRepository.delete(insertedTwisterPractice);
            insertedTwisterPractice = null;
        }
    }

    @Test
    @Transactional
    void createTwisterPractice() throws Exception {
        long databaseSizeBeforeCreate = getRepositoryCount();
        // Create the TwisterPractice
        var returnedTwisterPractice = om.readValue(
            restTwisterPracticeMockMvc
                .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(twisterPractice)))
                .andExpect(status().isCreated())
                .andReturn()
                .getResponse()
                .getContentAsString(),
            TwisterPractice.class
        );

        // Validate the TwisterPractice in the database
        assertIncrementedRepositoryCount(databaseSizeBeforeCreate);
        assertTwisterPracticeUpdatableFieldsEquals(returnedTwisterPractice, getPersistedTwisterPractice(returnedTwisterPractice));

        insertedTwisterPractice = returnedTwisterPractice;
    }

    @Test
    @Transactional
    void createTwisterPracticeWithExistingId() throws Exception {
        // Create the TwisterPractice with an existing ID
        twisterPractice.setId(1L);

        long databaseSizeBeforeCreate = getRepositoryCount();

        // An entity with an existing ID cannot be created, so this API call must fail
        restTwisterPracticeMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(twisterPractice)))
            .andExpect(status().isBadRequest());

        // Validate the TwisterPractice in the database
        assertSameRepositoryCount(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    void getAllTwisterPractices() throws Exception {
        // Initialize the database
        insertedTwisterPractice = twisterPracticeRepository.saveAndFlush(twisterPractice);

        // Get all the twisterPracticeList
        restTwisterPracticeMockMvc
            .perform(get(ENTITY_API_URL + "?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(twisterPractice.getId().intValue())))
            .andExpect(jsonPath("$.[*].score").value(hasItem(DEFAULT_SCORE)))
            .andExpect(jsonPath("$.[*].timesPracticed").value(hasItem(DEFAULT_TIMES_PRACTICED)))
            .andExpect(jsonPath("$.[*].corrections").value(hasItem(DEFAULT_CORRECTIONS)));
    }

    @Test
    @Transactional
    void getTwisterPractice() throws Exception {
        // Initialize the database
        insertedTwisterPractice = twisterPracticeRepository.saveAndFlush(twisterPractice);

        // Get the twisterPractice
        restTwisterPracticeMockMvc
            .perform(get(ENTITY_API_URL_ID, twisterPractice.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.id").value(twisterPractice.getId().intValue()))
            .andExpect(jsonPath("$.score").value(DEFAULT_SCORE))
            .andExpect(jsonPath("$.timesPracticed").value(DEFAULT_TIMES_PRACTICED))
            .andExpect(jsonPath("$.corrections").value(DEFAULT_CORRECTIONS));
    }

    @Test
    @Transactional
    void getNonExistingTwisterPractice() throws Exception {
        // Get the twisterPractice
        restTwisterPracticeMockMvc.perform(get(ENTITY_API_URL_ID, Long.MAX_VALUE)).andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    void putExistingTwisterPractice() throws Exception {
        // Initialize the database
        insertedTwisterPractice = twisterPracticeRepository.saveAndFlush(twisterPractice);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the twisterPractice
        TwisterPractice updatedTwisterPractice = twisterPracticeRepository.findById(twisterPractice.getId()).orElseThrow();
        // Disconnect from session so that the updates on updatedTwisterPractice are not directly saved in db
        em.detach(updatedTwisterPractice);
        updatedTwisterPractice.score(UPDATED_SCORE).timesPracticed(UPDATED_TIMES_PRACTICED).corrections(UPDATED_CORRECTIONS);

        restTwisterPracticeMockMvc
            .perform(
                put(ENTITY_API_URL_ID, updatedTwisterPractice.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(updatedTwisterPractice))
            )
            .andExpect(status().isOk());

        // Validate the TwisterPractice in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPersistedTwisterPracticeToMatchAllProperties(updatedTwisterPractice);
    }

    @Test
    @Transactional
    void putNonExistingTwisterPractice() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        twisterPractice.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restTwisterPracticeMockMvc
            .perform(
                put(ENTITY_API_URL_ID, twisterPractice.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(twisterPractice))
            )
            .andExpect(status().isBadRequest());

        // Validate the TwisterPractice in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithIdMismatchTwisterPractice() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        twisterPractice.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restTwisterPracticeMockMvc
            .perform(
                put(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(twisterPractice))
            )
            .andExpect(status().isBadRequest());

        // Validate the TwisterPractice in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithMissingIdPathParamTwisterPractice() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        twisterPractice.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restTwisterPracticeMockMvc
            .perform(put(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(twisterPractice)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the TwisterPractice in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void partialUpdateTwisterPracticeWithPatch() throws Exception {
        // Initialize the database
        insertedTwisterPractice = twisterPracticeRepository.saveAndFlush(twisterPractice);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the twisterPractice using partial update
        TwisterPractice partialUpdatedTwisterPractice = new TwisterPractice();
        partialUpdatedTwisterPractice.setId(twisterPractice.getId());

        partialUpdatedTwisterPractice.score(UPDATED_SCORE);

        restTwisterPracticeMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedTwisterPractice.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedTwisterPractice))
            )
            .andExpect(status().isOk());

        // Validate the TwisterPractice in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertTwisterPracticeUpdatableFieldsEquals(
            createUpdateProxyForBean(partialUpdatedTwisterPractice, twisterPractice),
            getPersistedTwisterPractice(twisterPractice)
        );
    }

    @Test
    @Transactional
    void fullUpdateTwisterPracticeWithPatch() throws Exception {
        // Initialize the database
        insertedTwisterPractice = twisterPracticeRepository.saveAndFlush(twisterPractice);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the twisterPractice using partial update
        TwisterPractice partialUpdatedTwisterPractice = new TwisterPractice();
        partialUpdatedTwisterPractice.setId(twisterPractice.getId());

        partialUpdatedTwisterPractice.score(UPDATED_SCORE).timesPracticed(UPDATED_TIMES_PRACTICED).corrections(UPDATED_CORRECTIONS);

        restTwisterPracticeMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedTwisterPractice.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedTwisterPractice))
            )
            .andExpect(status().isOk());

        // Validate the TwisterPractice in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertTwisterPracticeUpdatableFieldsEquals(
            partialUpdatedTwisterPractice,
            getPersistedTwisterPractice(partialUpdatedTwisterPractice)
        );
    }

    @Test
    @Transactional
    void patchNonExistingTwisterPractice() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        twisterPractice.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restTwisterPracticeMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, twisterPractice.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(twisterPractice))
            )
            .andExpect(status().isBadRequest());

        // Validate the TwisterPractice in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithIdMismatchTwisterPractice() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        twisterPractice.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restTwisterPracticeMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(twisterPractice))
            )
            .andExpect(status().isBadRequest());

        // Validate the TwisterPractice in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithMissingIdPathParamTwisterPractice() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        twisterPractice.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restTwisterPracticeMockMvc
            .perform(patch(ENTITY_API_URL).contentType("application/merge-patch+json").content(om.writeValueAsBytes(twisterPractice)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the TwisterPractice in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void deleteTwisterPractice() throws Exception {
        // Initialize the database
        insertedTwisterPractice = twisterPracticeRepository.saveAndFlush(twisterPractice);

        long databaseSizeBeforeDelete = getRepositoryCount();

        // Delete the twisterPractice
        restTwisterPracticeMockMvc
            .perform(delete(ENTITY_API_URL_ID, twisterPractice.getId()).accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isNoContent());

        // Validate the database contains one less item
        assertDecrementedRepositoryCount(databaseSizeBeforeDelete);
    }

    protected long getRepositoryCount() {
        return twisterPracticeRepository.count();
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

    protected TwisterPractice getPersistedTwisterPractice(TwisterPractice twisterPractice) {
        return twisterPracticeRepository.findById(twisterPractice.getId()).orElseThrow();
    }

    protected void assertPersistedTwisterPracticeToMatchAllProperties(TwisterPractice expectedTwisterPractice) {
        assertTwisterPracticeAllPropertiesEquals(expectedTwisterPractice, getPersistedTwisterPractice(expectedTwisterPractice));
    }

    protected void assertPersistedTwisterPracticeToMatchUpdatableProperties(TwisterPractice expectedTwisterPractice) {
        assertTwisterPracticeAllUpdatablePropertiesEquals(expectedTwisterPractice, getPersistedTwisterPractice(expectedTwisterPractice));
    }
}
