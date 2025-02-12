package com.lxisoft.emergencyalert.web.rest;

import static com.lxisoft.emergencyalert.domain.GpsEntryAsserts.*;
import static com.lxisoft.emergencyalert.web.rest.TestUtil.createUpdateProxyForBean;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lxisoft.emergencyalert.IntegrationTest;
import com.lxisoft.emergencyalert.domain.GpsEntry;
import com.lxisoft.emergencyalert.repository.GpsEntryRepository;
import com.lxisoft.emergencyalert.service.dto.GpsEntryDTO;
import com.lxisoft.emergencyalert.service.mapper.GpsEntryMapper;
import jakarta.persistence.EntityManager;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
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
 * Integration tests for the {@link GpsEntryResource} REST controller.
 */
@IntegrationTest
@AutoConfigureMockMvc
@WithMockUser
class GpsEntryResourceIT {

    private static final Double DEFAULT_LATITUDE = 1D;
    private static final Double UPDATED_LATITUDE = 2D;

    private static final Double DEFAULT_LONGITUDE = 1D;
    private static final Double UPDATED_LONGITUDE = 2D;

    private static final Instant DEFAULT_TIMESTAMP = Instant.ofEpochMilli(0L);
    private static final Instant UPDATED_TIMESTAMP = Instant.now().truncatedTo(ChronoUnit.MILLIS);

    private static final String DEFAULT_DEVICE_ID = "AAAAAAAAAA";
    private static final String UPDATED_DEVICE_ID = "BBBBBBBBBB";

    private static final String DEFAULT_STATUS = "AAAAAAAAAA";
    private static final String UPDATED_STATUS = "BBBBBBBBBB";

    private static final String ENTITY_API_URL = "/api/gps-entries";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private ObjectMapper om;

    @Autowired
    private GpsEntryRepository gpsEntryRepository;

    @Autowired
    private GpsEntryMapper gpsEntryMapper;

    @Autowired
    private EntityManager em;

    @Autowired
    private MockMvc restGpsEntryMockMvc;

    private GpsEntry gpsEntry;

    private GpsEntry insertedGpsEntry;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static GpsEntry createEntity() {
        return new GpsEntry()
            .latitude(DEFAULT_LATITUDE)
            .longitude(DEFAULT_LONGITUDE)
            .timestamp(DEFAULT_TIMESTAMP)
            .deviceId(DEFAULT_DEVICE_ID)
            .status(DEFAULT_STATUS);
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static GpsEntry createUpdatedEntity() {
        return new GpsEntry()
            .latitude(UPDATED_LATITUDE)
            .longitude(UPDATED_LONGITUDE)
            .timestamp(UPDATED_TIMESTAMP)
            .deviceId(UPDATED_DEVICE_ID)
            .status(UPDATED_STATUS);
    }

    @BeforeEach
    public void initTest() {
        gpsEntry = createEntity();
    }

    @AfterEach
    public void cleanup() {
        if (insertedGpsEntry != null) {
            gpsEntryRepository.delete(insertedGpsEntry);
            insertedGpsEntry = null;
        }
    }

    @Test
    @Transactional
    void createGpsEntry() throws Exception {
        long databaseSizeBeforeCreate = getRepositoryCount();
        // Create the GpsEntry
        GpsEntryDTO gpsEntryDTO = gpsEntryMapper.toDto(gpsEntry);
        var returnedGpsEntryDTO = om.readValue(
            restGpsEntryMockMvc
                .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(gpsEntryDTO)))
                .andExpect(status().isCreated())
                .andReturn()
                .getResponse()
                .getContentAsString(),
            GpsEntryDTO.class
        );

        // Validate the GpsEntry in the database
        assertIncrementedRepositoryCount(databaseSizeBeforeCreate);
        var returnedGpsEntry = gpsEntryMapper.toEntity(returnedGpsEntryDTO);
        assertGpsEntryUpdatableFieldsEquals(returnedGpsEntry, getPersistedGpsEntry(returnedGpsEntry));

        insertedGpsEntry = returnedGpsEntry;
    }

    @Test
    @Transactional
    void createGpsEntryWithExistingId() throws Exception {
        // Create the GpsEntry with an existing ID
        gpsEntry.setId(1L);
        GpsEntryDTO gpsEntryDTO = gpsEntryMapper.toDto(gpsEntry);

        long databaseSizeBeforeCreate = getRepositoryCount();

        // An entity with an existing ID cannot be created, so this API call must fail
        restGpsEntryMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(gpsEntryDTO)))
            .andExpect(status().isBadRequest());

        // Validate the GpsEntry in the database
        assertSameRepositoryCount(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    void checkLatitudeIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        gpsEntry.setLatitude(null);

        // Create the GpsEntry, which fails.
        GpsEntryDTO gpsEntryDTO = gpsEntryMapper.toDto(gpsEntry);

        restGpsEntryMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(gpsEntryDTO)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void checkLongitudeIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        gpsEntry.setLongitude(null);

        // Create the GpsEntry, which fails.
        GpsEntryDTO gpsEntryDTO = gpsEntryMapper.toDto(gpsEntry);

        restGpsEntryMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(gpsEntryDTO)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void checkTimestampIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        gpsEntry.setTimestamp(null);

        // Create the GpsEntry, which fails.
        GpsEntryDTO gpsEntryDTO = gpsEntryMapper.toDto(gpsEntry);

        restGpsEntryMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(gpsEntryDTO)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void checkDeviceIdIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        gpsEntry.setDeviceId(null);

        // Create the GpsEntry, which fails.
        GpsEntryDTO gpsEntryDTO = gpsEntryMapper.toDto(gpsEntry);

        restGpsEntryMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(gpsEntryDTO)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void checkStatusIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        gpsEntry.setStatus(null);

        // Create the GpsEntry, which fails.
        GpsEntryDTO gpsEntryDTO = gpsEntryMapper.toDto(gpsEntry);

        restGpsEntryMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(gpsEntryDTO)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void getAllGpsEntries() throws Exception {
        // Initialize the database
        insertedGpsEntry = gpsEntryRepository.saveAndFlush(gpsEntry);

        // Get all the gpsEntryList
        restGpsEntryMockMvc
            .perform(get(ENTITY_API_URL + "?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(gpsEntry.getId().intValue())))
            .andExpect(jsonPath("$.[*].latitude").value(hasItem(DEFAULT_LATITUDE)))
            .andExpect(jsonPath("$.[*].longitude").value(hasItem(DEFAULT_LONGITUDE)))
            .andExpect(jsonPath("$.[*].timestamp").value(hasItem(DEFAULT_TIMESTAMP.toString())))
            .andExpect(jsonPath("$.[*].deviceId").value(hasItem(DEFAULT_DEVICE_ID)))
            .andExpect(jsonPath("$.[*].status").value(hasItem(DEFAULT_STATUS)));
    }

    @Test
    @Transactional
    void getGpsEntry() throws Exception {
        // Initialize the database
        insertedGpsEntry = gpsEntryRepository.saveAndFlush(gpsEntry);

        // Get the gpsEntry
        restGpsEntryMockMvc
            .perform(get(ENTITY_API_URL_ID, gpsEntry.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.id").value(gpsEntry.getId().intValue()))
            .andExpect(jsonPath("$.latitude").value(DEFAULT_LATITUDE))
            .andExpect(jsonPath("$.longitude").value(DEFAULT_LONGITUDE))
            .andExpect(jsonPath("$.timestamp").value(DEFAULT_TIMESTAMP.toString()))
            .andExpect(jsonPath("$.deviceId").value(DEFAULT_DEVICE_ID))
            .andExpect(jsonPath("$.status").value(DEFAULT_STATUS));
    }

    @Test
    @Transactional
    void getNonExistingGpsEntry() throws Exception {
        // Get the gpsEntry
        restGpsEntryMockMvc.perform(get(ENTITY_API_URL_ID, Long.MAX_VALUE)).andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    void putExistingGpsEntry() throws Exception {
        // Initialize the database
        insertedGpsEntry = gpsEntryRepository.saveAndFlush(gpsEntry);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the gpsEntry
        GpsEntry updatedGpsEntry = gpsEntryRepository.findById(gpsEntry.getId()).orElseThrow();
        // Disconnect from session so that the updates on updatedGpsEntry are not directly saved in db
        em.detach(updatedGpsEntry);
        updatedGpsEntry
            .latitude(UPDATED_LATITUDE)
            .longitude(UPDATED_LONGITUDE)
            .timestamp(UPDATED_TIMESTAMP)
            .deviceId(UPDATED_DEVICE_ID)
            .status(UPDATED_STATUS);
        GpsEntryDTO gpsEntryDTO = gpsEntryMapper.toDto(updatedGpsEntry);

        restGpsEntryMockMvc
            .perform(
                put(ENTITY_API_URL_ID, gpsEntryDTO.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(gpsEntryDTO))
            )
            .andExpect(status().isOk());

        // Validate the GpsEntry in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPersistedGpsEntryToMatchAllProperties(updatedGpsEntry);
    }

    @Test
    @Transactional
    void putNonExistingGpsEntry() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        gpsEntry.setId(longCount.incrementAndGet());

        // Create the GpsEntry
        GpsEntryDTO gpsEntryDTO = gpsEntryMapper.toDto(gpsEntry);

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restGpsEntryMockMvc
            .perform(
                put(ENTITY_API_URL_ID, gpsEntryDTO.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(gpsEntryDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the GpsEntry in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithIdMismatchGpsEntry() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        gpsEntry.setId(longCount.incrementAndGet());

        // Create the GpsEntry
        GpsEntryDTO gpsEntryDTO = gpsEntryMapper.toDto(gpsEntry);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restGpsEntryMockMvc
            .perform(
                put(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(gpsEntryDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the GpsEntry in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithMissingIdPathParamGpsEntry() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        gpsEntry.setId(longCount.incrementAndGet());

        // Create the GpsEntry
        GpsEntryDTO gpsEntryDTO = gpsEntryMapper.toDto(gpsEntry);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restGpsEntryMockMvc
            .perform(put(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(gpsEntryDTO)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the GpsEntry in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void partialUpdateGpsEntryWithPatch() throws Exception {
        // Initialize the database
        insertedGpsEntry = gpsEntryRepository.saveAndFlush(gpsEntry);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the gpsEntry using partial update
        GpsEntry partialUpdatedGpsEntry = new GpsEntry();
        partialUpdatedGpsEntry.setId(gpsEntry.getId());

        partialUpdatedGpsEntry.timestamp(UPDATED_TIMESTAMP);

        restGpsEntryMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedGpsEntry.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedGpsEntry))
            )
            .andExpect(status().isOk());

        // Validate the GpsEntry in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertGpsEntryUpdatableFieldsEquals(createUpdateProxyForBean(partialUpdatedGpsEntry, gpsEntry), getPersistedGpsEntry(gpsEntry));
    }

    @Test
    @Transactional
    void fullUpdateGpsEntryWithPatch() throws Exception {
        // Initialize the database
        insertedGpsEntry = gpsEntryRepository.saveAndFlush(gpsEntry);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the gpsEntry using partial update
        GpsEntry partialUpdatedGpsEntry = new GpsEntry();
        partialUpdatedGpsEntry.setId(gpsEntry.getId());

        partialUpdatedGpsEntry
            .latitude(UPDATED_LATITUDE)
            .longitude(UPDATED_LONGITUDE)
            .timestamp(UPDATED_TIMESTAMP)
            .deviceId(UPDATED_DEVICE_ID)
            .status(UPDATED_STATUS);

        restGpsEntryMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedGpsEntry.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedGpsEntry))
            )
            .andExpect(status().isOk());

        // Validate the GpsEntry in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertGpsEntryUpdatableFieldsEquals(partialUpdatedGpsEntry, getPersistedGpsEntry(partialUpdatedGpsEntry));
    }

    @Test
    @Transactional
    void patchNonExistingGpsEntry() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        gpsEntry.setId(longCount.incrementAndGet());

        // Create the GpsEntry
        GpsEntryDTO gpsEntryDTO = gpsEntryMapper.toDto(gpsEntry);

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restGpsEntryMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, gpsEntryDTO.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(gpsEntryDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the GpsEntry in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithIdMismatchGpsEntry() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        gpsEntry.setId(longCount.incrementAndGet());

        // Create the GpsEntry
        GpsEntryDTO gpsEntryDTO = gpsEntryMapper.toDto(gpsEntry);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restGpsEntryMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(gpsEntryDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the GpsEntry in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithMissingIdPathParamGpsEntry() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        gpsEntry.setId(longCount.incrementAndGet());

        // Create the GpsEntry
        GpsEntryDTO gpsEntryDTO = gpsEntryMapper.toDto(gpsEntry);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restGpsEntryMockMvc
            .perform(patch(ENTITY_API_URL).contentType("application/merge-patch+json").content(om.writeValueAsBytes(gpsEntryDTO)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the GpsEntry in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void deleteGpsEntry() throws Exception {
        // Initialize the database
        insertedGpsEntry = gpsEntryRepository.saveAndFlush(gpsEntry);

        long databaseSizeBeforeDelete = getRepositoryCount();

        // Delete the gpsEntry
        restGpsEntryMockMvc
            .perform(delete(ENTITY_API_URL_ID, gpsEntry.getId()).accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isNoContent());

        // Validate the database contains one less item
        assertDecrementedRepositoryCount(databaseSizeBeforeDelete);
    }

    protected long getRepositoryCount() {
        return gpsEntryRepository.count();
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

    protected GpsEntry getPersistedGpsEntry(GpsEntry gpsEntry) {
        return gpsEntryRepository.findById(gpsEntry.getId()).orElseThrow();
    }

    protected void assertPersistedGpsEntryToMatchAllProperties(GpsEntry expectedGpsEntry) {
        assertGpsEntryAllPropertiesEquals(expectedGpsEntry, getPersistedGpsEntry(expectedGpsEntry));
    }

    protected void assertPersistedGpsEntryToMatchUpdatableProperties(GpsEntry expectedGpsEntry) {
        assertGpsEntryAllUpdatablePropertiesEquals(expectedGpsEntry, getPersistedGpsEntry(expectedGpsEntry));
    }
}
