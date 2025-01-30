package com.diviso.habittrack.web.rest;

import static com.diviso.habittrack.domain.HabitTrackAsserts.*;
import static com.diviso.habittrack.web.rest.TestUtil.createUpdateProxyForBean;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.diviso.habittrack.IntegrationTest;
import com.diviso.habittrack.domain.HabitTrack;
import com.diviso.habittrack.repository.HabitTrackRepository;
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
 * Integration tests for the {@link HabitTrackResource} REST controller.
 */
@IntegrationTest
@AutoConfigureMockMvc
@WithMockUser
class HabitTrackResourceIT {

    private static final Integer DEFAULT_HABIT_ID = 1;
    private static final Integer UPDATED_HABIT_ID = 2;

    private static final String DEFAULT_HABIT_NAME = "AAAAAAAAAA";
    private static final String UPDATED_HABIT_NAME = "BBBBBBBBBB";

    private static final String DEFAULT_DESCRIPTION = "AAAAAAAAAA";
    private static final String UPDATED_DESCRIPTION = "BBBBBBBBBB";

    private static final String DEFAULT_CATEGORY = "AAAAAAAAAA";
    private static final String UPDATED_CATEGORY = "BBBBBBBBBB";

    private static final String DEFAULT_START_DATE = "AAAAAAAAAA";
    private static final String UPDATED_START_DATE = "BBBBBBBBBB";

    private static final String DEFAULT_END_DATE = "AAAAAAAAAA";
    private static final String UPDATED_END_DATE = "BBBBBBBBBB";

    private static final String ENTITY_API_URL = "/api/habit-tracks";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private ObjectMapper om;

    @Autowired
    private HabitTrackRepository habitTrackRepository;

    @Autowired
    private EntityManager em;

    @Autowired
    private MockMvc restHabitTrackMockMvc;

    private HabitTrack habitTrack;

    private HabitTrack insertedHabitTrack;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static HabitTrack createEntity() {
        return new HabitTrack()
            .habitId(DEFAULT_HABIT_ID)
            .habitName(DEFAULT_HABIT_NAME)
            .description(DEFAULT_DESCRIPTION)
            .category(DEFAULT_CATEGORY)
            .startDate(DEFAULT_START_DATE)
            .endDate(DEFAULT_END_DATE);
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static HabitTrack createUpdatedEntity() {
        return new HabitTrack()
            .habitId(UPDATED_HABIT_ID)
            .habitName(UPDATED_HABIT_NAME)
            .description(UPDATED_DESCRIPTION)
            .category(UPDATED_CATEGORY)
            .startDate(UPDATED_START_DATE)
            .endDate(UPDATED_END_DATE);
    }

    @BeforeEach
    public void initTest() {
        habitTrack = createEntity();
    }

    @AfterEach
    public void cleanup() {
        if (insertedHabitTrack != null) {
            habitTrackRepository.delete(insertedHabitTrack);
            insertedHabitTrack = null;
        }
    }

    @Test
    @Transactional
    void createHabitTrack() throws Exception {
        long databaseSizeBeforeCreate = getRepositoryCount();
        // Create the HabitTrack
        var returnedHabitTrack = om.readValue(
            restHabitTrackMockMvc
                .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(habitTrack)))
                .andExpect(status().isCreated())
                .andReturn()
                .getResponse()
                .getContentAsString(),
            HabitTrack.class
        );

        // Validate the HabitTrack in the database
        assertIncrementedRepositoryCount(databaseSizeBeforeCreate);
        assertHabitTrackUpdatableFieldsEquals(returnedHabitTrack, getPersistedHabitTrack(returnedHabitTrack));

        insertedHabitTrack = returnedHabitTrack;
    }

    @Test
    @Transactional
    void createHabitTrackWithExistingId() throws Exception {
        // Create the HabitTrack with an existing ID
        habitTrack.setId(1L);

        long databaseSizeBeforeCreate = getRepositoryCount();

        // An entity with an existing ID cannot be created, so this API call must fail
        restHabitTrackMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(habitTrack)))
            .andExpect(status().isBadRequest());

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    void getAllHabitTracks() throws Exception {
        // Initialize the database
        insertedHabitTrack = habitTrackRepository.saveAndFlush(habitTrack);

        // Get all the habitTrackList
        restHabitTrackMockMvc
            .perform(get(ENTITY_API_URL + "?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(habitTrack.getId().intValue())))
            .andExpect(jsonPath("$.[*].habitId").value(hasItem(DEFAULT_HABIT_ID)))
            .andExpect(jsonPath("$.[*].habitName").value(hasItem(DEFAULT_HABIT_NAME)))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            .andExpect(jsonPath("$.[*].category").value(hasItem(DEFAULT_CATEGORY)))
            .andExpect(jsonPath("$.[*].startDate").value(hasItem(DEFAULT_START_DATE)))
            .andExpect(jsonPath("$.[*].endDate").value(hasItem(DEFAULT_END_DATE)));
    }

    @Test
    @Transactional
    void getHabitTrack() throws Exception {
        // Initialize the database
        insertedHabitTrack = habitTrackRepository.saveAndFlush(habitTrack);

        // Get the habitTrack
        restHabitTrackMockMvc
            .perform(get(ENTITY_API_URL_ID, habitTrack.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.id").value(habitTrack.getId().intValue()))
            .andExpect(jsonPath("$.habitId").value(DEFAULT_HABIT_ID))
            .andExpect(jsonPath("$.habitName").value(DEFAULT_HABIT_NAME))
            .andExpect(jsonPath("$.description").value(DEFAULT_DESCRIPTION))
            .andExpect(jsonPath("$.category").value(DEFAULT_CATEGORY))
            .andExpect(jsonPath("$.startDate").value(DEFAULT_START_DATE))
            .andExpect(jsonPath("$.endDate").value(DEFAULT_END_DATE));
    }

    @Test
    @Transactional
    void getNonExistingHabitTrack() throws Exception {
        // Get the habitTrack
        restHabitTrackMockMvc.perform(get(ENTITY_API_URL_ID, Long.MAX_VALUE)).andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    void putExistingHabitTrack() throws Exception {
        // Initialize the database
        insertedHabitTrack = habitTrackRepository.saveAndFlush(habitTrack);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the habitTrack
        HabitTrack updatedHabitTrack = habitTrackRepository.findById(habitTrack.getId()).orElseThrow();
        // Disconnect from session so that the updates on updatedHabitTrack are not directly saved in db
        em.detach(updatedHabitTrack);
        updatedHabitTrack
            .habitId(UPDATED_HABIT_ID)
            .habitName(UPDATED_HABIT_NAME)
            .description(UPDATED_DESCRIPTION)
            .category(UPDATED_CATEGORY)
            .startDate(UPDATED_START_DATE)
            .endDate(UPDATED_END_DATE);

        restHabitTrackMockMvc
            .perform(
                put(ENTITY_API_URL_ID, updatedHabitTrack.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(updatedHabitTrack))
            )
            .andExpect(status().isOk());

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPersistedHabitTrackToMatchAllProperties(updatedHabitTrack);
    }

    @Test
    @Transactional
    void putNonExistingHabitTrack() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        habitTrack.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restHabitTrackMockMvc
            .perform(
                put(ENTITY_API_URL_ID, habitTrack.getId()).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(habitTrack))
            )
            .andExpect(status().isBadRequest());

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithIdMismatchHabitTrack() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        habitTrack.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restHabitTrackMockMvc
            .perform(
                put(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(habitTrack))
            )
            .andExpect(status().isBadRequest());

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithMissingIdPathParamHabitTrack() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        habitTrack.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restHabitTrackMockMvc
            .perform(put(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(habitTrack)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void partialUpdateHabitTrackWithPatch() throws Exception {
        // Initialize the database
        insertedHabitTrack = habitTrackRepository.saveAndFlush(habitTrack);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the habitTrack using partial update
        HabitTrack partialUpdatedHabitTrack = new HabitTrack();
        partialUpdatedHabitTrack.setId(habitTrack.getId());

        partialUpdatedHabitTrack.habitName(UPDATED_HABIT_NAME).description(UPDATED_DESCRIPTION).endDate(UPDATED_END_DATE);

        restHabitTrackMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedHabitTrack.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedHabitTrack))
            )
            .andExpect(status().isOk());

        // Validate the HabitTrack in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertHabitTrackUpdatableFieldsEquals(
            createUpdateProxyForBean(partialUpdatedHabitTrack, habitTrack),
            getPersistedHabitTrack(habitTrack)
        );
    }

    @Test
    @Transactional
    void fullUpdateHabitTrackWithPatch() throws Exception {
        // Initialize the database
        insertedHabitTrack = habitTrackRepository.saveAndFlush(habitTrack);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the habitTrack using partial update
        HabitTrack partialUpdatedHabitTrack = new HabitTrack();
        partialUpdatedHabitTrack.setId(habitTrack.getId());

        partialUpdatedHabitTrack
            .habitId(UPDATED_HABIT_ID)
            .habitName(UPDATED_HABIT_NAME)
            .description(UPDATED_DESCRIPTION)
            .category(UPDATED_CATEGORY)
            .startDate(UPDATED_START_DATE)
            .endDate(UPDATED_END_DATE);

        restHabitTrackMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedHabitTrack.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedHabitTrack))
            )
            .andExpect(status().isOk());

        // Validate the HabitTrack in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertHabitTrackUpdatableFieldsEquals(partialUpdatedHabitTrack, getPersistedHabitTrack(partialUpdatedHabitTrack));
    }

    @Test
    @Transactional
    void patchNonExistingHabitTrack() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        habitTrack.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restHabitTrackMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, habitTrack.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(habitTrack))
            )
            .andExpect(status().isBadRequest());

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithIdMismatchHabitTrack() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        habitTrack.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restHabitTrackMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(habitTrack))
            )
            .andExpect(status().isBadRequest());

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithMissingIdPathParamHabitTrack() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        habitTrack.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restHabitTrackMockMvc
            .perform(patch(ENTITY_API_URL).contentType("application/merge-patch+json").content(om.writeValueAsBytes(habitTrack)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void deleteHabitTrack() throws Exception {
        // Initialize the database
        insertedHabitTrack = habitTrackRepository.saveAndFlush(habitTrack);

        long databaseSizeBeforeDelete = getRepositoryCount();

        // Delete the habitTrack
        restHabitTrackMockMvc
            .perform(delete(ENTITY_API_URL_ID, habitTrack.getId()).accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isNoContent());

        // Validate the database contains one less item
        assertDecrementedRepositoryCount(databaseSizeBeforeDelete);
    }

    protected long getRepositoryCount() {
        return habitTrackRepository.count();
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

    protected HabitTrack getPersistedHabitTrack(HabitTrack habitTrack) {
        return habitTrackRepository.findById(habitTrack.getId()).orElseThrow();
    }

    protected void assertPersistedHabitTrackToMatchAllProperties(HabitTrack expectedHabitTrack) {
        assertHabitTrackAllPropertiesEquals(expectedHabitTrack, getPersistedHabitTrack(expectedHabitTrack));
    }

    protected void assertPersistedHabitTrackToMatchUpdatableProperties(HabitTrack expectedHabitTrack) {
        assertHabitTrackAllUpdatablePropertiesEquals(expectedHabitTrack, getPersistedHabitTrack(expectedHabitTrack));
    }
}
