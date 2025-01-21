package com.diviso.perfectday.web.rest;

import static com.diviso.perfectday.domain.PerfectDayAsserts.*;
import static com.diviso.perfectday.web.rest.TestUtil.createUpdateProxyForBean;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.diviso.perfectday.IntegrationTest;
import com.diviso.perfectday.domain.PerfectDay;
import com.diviso.perfectday.repository.PerfectDayRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.EntityManager;
import java.time.LocalDate;
import java.time.ZoneId;
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
 * Integration tests for the {@link PerfectDayResource} REST controller.
 */
@IntegrationTest
@AutoConfigureMockMvc
@WithMockUser
class PerfectDayResourceIT {

    private static final String DEFAULT_TITLE = "AAAAAAAAAA";
    private static final String UPDATED_TITLE = "BBBBBBBBBB";

    private static final String DEFAULT_DESCRIPTION = "AAAAAAAAAA";
    private static final String UPDATED_DESCRIPTION = "BBBBBBBBBB";

    private static final LocalDate DEFAULT_DATE = LocalDate.ofEpochDay(0L);
    private static final LocalDate UPDATED_DATE = LocalDate.now(ZoneId.systemDefault());

    private static final String ENTITY_API_URL = "/api/perfect-days";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private ObjectMapper om;

    @Autowired
    private PerfectDayRepository perfectDayRepository;

    @Autowired
    private EntityManager em;

    @Autowired
    private MockMvc restPerfectDayMockMvc;

    private PerfectDay perfectDay;

    private PerfectDay insertedPerfectDay;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static PerfectDay createEntity() {
        return new PerfectDay().title(DEFAULT_TITLE).description(DEFAULT_DESCRIPTION).date(DEFAULT_DATE);
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static PerfectDay createUpdatedEntity() {
        return new PerfectDay().title(UPDATED_TITLE).description(UPDATED_DESCRIPTION).date(UPDATED_DATE);
    }

    @BeforeEach
    public void initTest() {
        perfectDay = createEntity();
    }

    @AfterEach
    public void cleanup() {
        if (insertedPerfectDay != null) {
            perfectDayRepository.delete(insertedPerfectDay);
            insertedPerfectDay = null;
        }
    }

    @Test
    @Transactional
    void createPerfectDay() throws Exception {
        long databaseSizeBeforeCreate = getRepositoryCount();
        // Create the PerfectDay
        var returnedPerfectDay = om.readValue(
            restPerfectDayMockMvc
                .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(perfectDay)))
                .andExpect(status().isCreated())
                .andReturn()
                .getResponse()
                .getContentAsString(),
            PerfectDay.class
        );

        // Validate the PerfectDay in the database
        assertIncrementedRepositoryCount(databaseSizeBeforeCreate);
        assertPerfectDayUpdatableFieldsEquals(returnedPerfectDay, getPersistedPerfectDay(returnedPerfectDay));

        insertedPerfectDay = returnedPerfectDay;
    }

    @Test
    @Transactional
    void createPerfectDayWithExistingId() throws Exception {
        // Create the PerfectDay with an existing ID
        perfectDay.setId(1L);

        long databaseSizeBeforeCreate = getRepositoryCount();

        // An entity with an existing ID cannot be created, so this API call must fail
        restPerfectDayMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(perfectDay)))
            .andExpect(status().isBadRequest());

        // Validate the PerfectDay in the database
        assertSameRepositoryCount(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    void checkTitleIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        perfectDay.setTitle(null);

        // Create the PerfectDay, which fails.

        restPerfectDayMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(perfectDay)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void checkDateIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        perfectDay.setDate(null);

        // Create the PerfectDay, which fails.

        restPerfectDayMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(perfectDay)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void getAllPerfectDays() throws Exception {
        // Initialize the database
        insertedPerfectDay = perfectDayRepository.saveAndFlush(perfectDay);

        // Get all the perfectDayList
        restPerfectDayMockMvc
            .perform(get(ENTITY_API_URL + "?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(perfectDay.getId().intValue())))
            .andExpect(jsonPath("$.[*].title").value(hasItem(DEFAULT_TITLE)))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            .andExpect(jsonPath("$.[*].date").value(hasItem(DEFAULT_DATE.toString())));
    }

    @Test
    @Transactional
    void getPerfectDay() throws Exception {
        // Initialize the database
        insertedPerfectDay = perfectDayRepository.saveAndFlush(perfectDay);

        // Get the perfectDay
        restPerfectDayMockMvc
            .perform(get(ENTITY_API_URL_ID, perfectDay.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.id").value(perfectDay.getId().intValue()))
            .andExpect(jsonPath("$.title").value(DEFAULT_TITLE))
            .andExpect(jsonPath("$.description").value(DEFAULT_DESCRIPTION))
            .andExpect(jsonPath("$.date").value(DEFAULT_DATE.toString()));
    }

    @Test
    @Transactional
    void getNonExistingPerfectDay() throws Exception {
        // Get the perfectDay
        restPerfectDayMockMvc.perform(get(ENTITY_API_URL_ID, Long.MAX_VALUE)).andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    void putExistingPerfectDay() throws Exception {
        // Initialize the database
        insertedPerfectDay = perfectDayRepository.saveAndFlush(perfectDay);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the perfectDay
        PerfectDay updatedPerfectDay = perfectDayRepository.findById(perfectDay.getId()).orElseThrow();
        // Disconnect from session so that the updates on updatedPerfectDay are not directly saved in db
        em.detach(updatedPerfectDay);
        updatedPerfectDay.title(UPDATED_TITLE).description(UPDATED_DESCRIPTION).date(UPDATED_DATE);

        restPerfectDayMockMvc
            .perform(
                put(ENTITY_API_URL_ID, updatedPerfectDay.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(updatedPerfectDay))
            )
            .andExpect(status().isOk());

        // Validate the PerfectDay in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPersistedPerfectDayToMatchAllProperties(updatedPerfectDay);
    }

    @Test
    @Transactional
    void putNonExistingPerfectDay() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        perfectDay.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restPerfectDayMockMvc
            .perform(
                put(ENTITY_API_URL_ID, perfectDay.getId()).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(perfectDay))
            )
            .andExpect(status().isBadRequest());

        // Validate the PerfectDay in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithIdMismatchPerfectDay() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        perfectDay.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restPerfectDayMockMvc
            .perform(
                put(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(perfectDay))
            )
            .andExpect(status().isBadRequest());

        // Validate the PerfectDay in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithMissingIdPathParamPerfectDay() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        perfectDay.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restPerfectDayMockMvc
            .perform(put(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(perfectDay)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the PerfectDay in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void partialUpdatePerfectDayWithPatch() throws Exception {
        // Initialize the database
        insertedPerfectDay = perfectDayRepository.saveAndFlush(perfectDay);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the perfectDay using partial update
        PerfectDay partialUpdatedPerfectDay = new PerfectDay();
        partialUpdatedPerfectDay.setId(perfectDay.getId());

        partialUpdatedPerfectDay.title(UPDATED_TITLE);

        restPerfectDayMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedPerfectDay.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedPerfectDay))
            )
            .andExpect(status().isOk());

        // Validate the PerfectDay in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPerfectDayUpdatableFieldsEquals(
            createUpdateProxyForBean(partialUpdatedPerfectDay, perfectDay),
            getPersistedPerfectDay(perfectDay)
        );
    }

    @Test
    @Transactional
    void fullUpdatePerfectDayWithPatch() throws Exception {
        // Initialize the database
        insertedPerfectDay = perfectDayRepository.saveAndFlush(perfectDay);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the perfectDay using partial update
        PerfectDay partialUpdatedPerfectDay = new PerfectDay();
        partialUpdatedPerfectDay.setId(perfectDay.getId());

        partialUpdatedPerfectDay.title(UPDATED_TITLE).description(UPDATED_DESCRIPTION).date(UPDATED_DATE);

        restPerfectDayMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedPerfectDay.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedPerfectDay))
            )
            .andExpect(status().isOk());

        // Validate the PerfectDay in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPerfectDayUpdatableFieldsEquals(partialUpdatedPerfectDay, getPersistedPerfectDay(partialUpdatedPerfectDay));
    }

    @Test
    @Transactional
    void patchNonExistingPerfectDay() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        perfectDay.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restPerfectDayMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, perfectDay.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(perfectDay))
            )
            .andExpect(status().isBadRequest());

        // Validate the PerfectDay in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithIdMismatchPerfectDay() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        perfectDay.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restPerfectDayMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(perfectDay))
            )
            .andExpect(status().isBadRequest());

        // Validate the PerfectDay in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithMissingIdPathParamPerfectDay() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        perfectDay.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restPerfectDayMockMvc
            .perform(patch(ENTITY_API_URL).contentType("application/merge-patch+json").content(om.writeValueAsBytes(perfectDay)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the PerfectDay in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void deletePerfectDay() throws Exception {
        // Initialize the database
        insertedPerfectDay = perfectDayRepository.saveAndFlush(perfectDay);

        long databaseSizeBeforeDelete = getRepositoryCount();

        // Delete the perfectDay
        restPerfectDayMockMvc
            .perform(delete(ENTITY_API_URL_ID, perfectDay.getId()).accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isNoContent());

        // Validate the database contains one less item
        assertDecrementedRepositoryCount(databaseSizeBeforeDelete);
    }

    protected long getRepositoryCount() {
        return perfectDayRepository.count();
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

    protected PerfectDay getPersistedPerfectDay(PerfectDay perfectDay) {
        return perfectDayRepository.findById(perfectDay.getId()).orElseThrow();
    }

    protected void assertPersistedPerfectDayToMatchAllProperties(PerfectDay expectedPerfectDay) {
        assertPerfectDayAllPropertiesEquals(expectedPerfectDay, getPersistedPerfectDay(expectedPerfectDay));
    }

    protected void assertPersistedPerfectDayToMatchUpdatableProperties(PerfectDay expectedPerfectDay) {
        assertPerfectDayAllUpdatablePropertiesEquals(expectedPerfectDay, getPersistedPerfectDay(expectedPerfectDay));
    }
}
