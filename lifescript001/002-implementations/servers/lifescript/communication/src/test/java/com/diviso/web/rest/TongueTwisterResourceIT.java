package com.diviso.web.rest;

import static com.diviso.domain.TongueTwisterAsserts.*;
import static com.diviso.web.rest.TestUtil.createUpdateProxyForBean;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.diviso.IntegrationTest;
import com.diviso.domain.TongueTwister;
import com.diviso.repository.TongueTwisterRepository;
import com.diviso.repository.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.EntityManager;
import java.util.ArrayList;
import java.util.Random;
import java.util.concurrent.atomic.AtomicLong;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

/**
 * Integration tests for the {@link TongueTwisterResource} REST controller.
 */
@IntegrationTest
@ExtendWith(MockitoExtension.class)
@AutoConfigureMockMvc
@WithMockUser
class TongueTwisterResourceIT {

    private static final String DEFAULT_TEXT = "AAAAAAAAAA";
    private static final String UPDATED_TEXT = "BBBBBBBBBB";

    private static final String DEFAULT_LANGUAGE = "AAAAAAAAAA";
    private static final String UPDATED_LANGUAGE = "BBBBBBBBBB";

    private static final Integer DEFAULT_DIFFICULTY_LEVEL = 1;
    private static final Integer UPDATED_DIFFICULTY_LEVEL = 2;

    private static final String ENTITY_API_URL = "/api/tongue-twisters";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private ObjectMapper om;

    @Autowired
    private TongueTwisterRepository tongueTwisterRepository;

    @Autowired
    private UserRepository userRepository;

    @Mock
    private TongueTwisterRepository tongueTwisterRepositoryMock;

    @Autowired
    private EntityManager em;

    @Autowired
    private MockMvc restTongueTwisterMockMvc;

    private TongueTwister tongueTwister;

    private TongueTwister insertedTongueTwister;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static TongueTwister createEntity() {
        return new TongueTwister().text(DEFAULT_TEXT).language(DEFAULT_LANGUAGE).difficultyLevel(DEFAULT_DIFFICULTY_LEVEL);
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static TongueTwister createUpdatedEntity() {
        return new TongueTwister().text(UPDATED_TEXT).language(UPDATED_LANGUAGE).difficultyLevel(UPDATED_DIFFICULTY_LEVEL);
    }

    @BeforeEach
    public void initTest() {
        tongueTwister = createEntity();
    }

    @AfterEach
    public void cleanup() {
        if (insertedTongueTwister != null) {
            tongueTwisterRepository.delete(insertedTongueTwister);
            insertedTongueTwister = null;
        }
    }

    @Test
    @Transactional
    void createTongueTwister() throws Exception {
        long databaseSizeBeforeCreate = getRepositoryCount();
        // Create the TongueTwister
        var returnedTongueTwister = om.readValue(
            restTongueTwisterMockMvc
                .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(tongueTwister)))
                .andExpect(status().isCreated())
                .andReturn()
                .getResponse()
                .getContentAsString(),
            TongueTwister.class
        );

        // Validate the TongueTwister in the database
        assertIncrementedRepositoryCount(databaseSizeBeforeCreate);
        assertTongueTwisterUpdatableFieldsEquals(returnedTongueTwister, getPersistedTongueTwister(returnedTongueTwister));

        insertedTongueTwister = returnedTongueTwister;
    }

    @Test
    @Transactional
    void createTongueTwisterWithExistingId() throws Exception {
        // Create the TongueTwister with an existing ID
        tongueTwister.setId(1L);

        long databaseSizeBeforeCreate = getRepositoryCount();

        // An entity with an existing ID cannot be created, so this API call must fail
        restTongueTwisterMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(tongueTwister)))
            .andExpect(status().isBadRequest());

        // Validate the TongueTwister in the database
        assertSameRepositoryCount(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    void checkTextIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        tongueTwister.setText(null);

        // Create the TongueTwister, which fails.

        restTongueTwisterMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(tongueTwister)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void checkLanguageIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        tongueTwister.setLanguage(null);

        // Create the TongueTwister, which fails.

        restTongueTwisterMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(tongueTwister)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void getAllTongueTwisters() throws Exception {
        // Initialize the database
        insertedTongueTwister = tongueTwisterRepository.saveAndFlush(tongueTwister);

        // Get all the tongueTwisterList
        restTongueTwisterMockMvc
            .perform(get(ENTITY_API_URL + "?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(tongueTwister.getId().intValue())))
            .andExpect(jsonPath("$.[*].text").value(hasItem(DEFAULT_TEXT)))
            .andExpect(jsonPath("$.[*].language").value(hasItem(DEFAULT_LANGUAGE)))
            .andExpect(jsonPath("$.[*].difficultyLevel").value(hasItem(DEFAULT_DIFFICULTY_LEVEL)));
    }

    @SuppressWarnings({ "unchecked" })
    void getAllTongueTwistersWithEagerRelationshipsIsEnabled() throws Exception {
        when(tongueTwisterRepositoryMock.findAllWithEagerRelationships(any())).thenReturn(new PageImpl(new ArrayList<>()));

        restTongueTwisterMockMvc.perform(get(ENTITY_API_URL + "?eagerload=true")).andExpect(status().isOk());

        verify(tongueTwisterRepositoryMock, times(1)).findAllWithEagerRelationships(any());
    }

    @SuppressWarnings({ "unchecked" })
    void getAllTongueTwistersWithEagerRelationshipsIsNotEnabled() throws Exception {
        when(tongueTwisterRepositoryMock.findAllWithEagerRelationships(any())).thenReturn(new PageImpl(new ArrayList<>()));

        restTongueTwisterMockMvc.perform(get(ENTITY_API_URL + "?eagerload=false")).andExpect(status().isOk());
        verify(tongueTwisterRepositoryMock, times(1)).findAll(any(Pageable.class));
    }

    @Test
    @Transactional
    void getTongueTwister() throws Exception {
        // Initialize the database
        insertedTongueTwister = tongueTwisterRepository.saveAndFlush(tongueTwister);

        // Get the tongueTwister
        restTongueTwisterMockMvc
            .perform(get(ENTITY_API_URL_ID, tongueTwister.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.id").value(tongueTwister.getId().intValue()))
            .andExpect(jsonPath("$.text").value(DEFAULT_TEXT))
            .andExpect(jsonPath("$.language").value(DEFAULT_LANGUAGE))
            .andExpect(jsonPath("$.difficultyLevel").value(DEFAULT_DIFFICULTY_LEVEL));
    }

    @Test
    @Transactional
    void getNonExistingTongueTwister() throws Exception {
        // Get the tongueTwister
        restTongueTwisterMockMvc.perform(get(ENTITY_API_URL_ID, Long.MAX_VALUE)).andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    void putExistingTongueTwister() throws Exception {
        // Initialize the database
        insertedTongueTwister = tongueTwisterRepository.saveAndFlush(tongueTwister);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the tongueTwister
        TongueTwister updatedTongueTwister = tongueTwisterRepository.findById(tongueTwister.getId()).orElseThrow();
        // Disconnect from session so that the updates on updatedTongueTwister are not directly saved in db
        em.detach(updatedTongueTwister);
        updatedTongueTwister.text(UPDATED_TEXT).language(UPDATED_LANGUAGE).difficultyLevel(UPDATED_DIFFICULTY_LEVEL);

        restTongueTwisterMockMvc
            .perform(
                put(ENTITY_API_URL_ID, updatedTongueTwister.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(updatedTongueTwister))
            )
            .andExpect(status().isOk());

        // Validate the TongueTwister in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPersistedTongueTwisterToMatchAllProperties(updatedTongueTwister);
    }

    @Test
    @Transactional
    void putNonExistingTongueTwister() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        tongueTwister.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restTongueTwisterMockMvc
            .perform(
                put(ENTITY_API_URL_ID, tongueTwister.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(tongueTwister))
            )
            .andExpect(status().isBadRequest());

        // Validate the TongueTwister in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithIdMismatchTongueTwister() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        tongueTwister.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restTongueTwisterMockMvc
            .perform(
                put(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(tongueTwister))
            )
            .andExpect(status().isBadRequest());

        // Validate the TongueTwister in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithMissingIdPathParamTongueTwister() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        tongueTwister.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restTongueTwisterMockMvc
            .perform(put(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(tongueTwister)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the TongueTwister in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void partialUpdateTongueTwisterWithPatch() throws Exception {
        // Initialize the database
        insertedTongueTwister = tongueTwisterRepository.saveAndFlush(tongueTwister);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the tongueTwister using partial update
        TongueTwister partialUpdatedTongueTwister = new TongueTwister();
        partialUpdatedTongueTwister.setId(tongueTwister.getId());

        partialUpdatedTongueTwister.text(UPDATED_TEXT).difficultyLevel(UPDATED_DIFFICULTY_LEVEL);

        restTongueTwisterMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedTongueTwister.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedTongueTwister))
            )
            .andExpect(status().isOk());

        // Validate the TongueTwister in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertTongueTwisterUpdatableFieldsEquals(
            createUpdateProxyForBean(partialUpdatedTongueTwister, tongueTwister),
            getPersistedTongueTwister(tongueTwister)
        );
    }

    @Test
    @Transactional
    void fullUpdateTongueTwisterWithPatch() throws Exception {
        // Initialize the database
        insertedTongueTwister = tongueTwisterRepository.saveAndFlush(tongueTwister);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the tongueTwister using partial update
        TongueTwister partialUpdatedTongueTwister = new TongueTwister();
        partialUpdatedTongueTwister.setId(tongueTwister.getId());

        partialUpdatedTongueTwister.text(UPDATED_TEXT).language(UPDATED_LANGUAGE).difficultyLevel(UPDATED_DIFFICULTY_LEVEL);

        restTongueTwisterMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedTongueTwister.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedTongueTwister))
            )
            .andExpect(status().isOk());

        // Validate the TongueTwister in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertTongueTwisterUpdatableFieldsEquals(partialUpdatedTongueTwister, getPersistedTongueTwister(partialUpdatedTongueTwister));
    }

    @Test
    @Transactional
    void patchNonExistingTongueTwister() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        tongueTwister.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restTongueTwisterMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, tongueTwister.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(tongueTwister))
            )
            .andExpect(status().isBadRequest());

        // Validate the TongueTwister in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithIdMismatchTongueTwister() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        tongueTwister.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restTongueTwisterMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(tongueTwister))
            )
            .andExpect(status().isBadRequest());

        // Validate the TongueTwister in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithMissingIdPathParamTongueTwister() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        tongueTwister.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restTongueTwisterMockMvc
            .perform(patch(ENTITY_API_URL).contentType("application/merge-patch+json").content(om.writeValueAsBytes(tongueTwister)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the TongueTwister in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void deleteTongueTwister() throws Exception {
        // Initialize the database
        insertedTongueTwister = tongueTwisterRepository.saveAndFlush(tongueTwister);

        long databaseSizeBeforeDelete = getRepositoryCount();

        // Delete the tongueTwister
        restTongueTwisterMockMvc
            .perform(delete(ENTITY_API_URL_ID, tongueTwister.getId()).accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isNoContent());

        // Validate the database contains one less item
        assertDecrementedRepositoryCount(databaseSizeBeforeDelete);
    }

    protected long getRepositoryCount() {
        return tongueTwisterRepository.count();
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

    protected TongueTwister getPersistedTongueTwister(TongueTwister tongueTwister) {
        return tongueTwisterRepository.findById(tongueTwister.getId()).orElseThrow();
    }

    protected void assertPersistedTongueTwisterToMatchAllProperties(TongueTwister expectedTongueTwister) {
        assertTongueTwisterAllPropertiesEquals(expectedTongueTwister, getPersistedTongueTwister(expectedTongueTwister));
    }

    protected void assertPersistedTongueTwisterToMatchUpdatableProperties(TongueTwister expectedTongueTwister) {
        assertTongueTwisterAllUpdatablePropertiesEquals(expectedTongueTwister, getPersistedTongueTwister(expectedTongueTwister));
    }
}
