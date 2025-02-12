package com.lxisoft.emergencyalert.web.rest;

import static com.lxisoft.emergencyalert.domain.BatteryStatusAsserts.*;
import static com.lxisoft.emergencyalert.web.rest.TestUtil.createUpdateProxyForBean;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lxisoft.emergencyalert.IntegrationTest;
import com.lxisoft.emergencyalert.domain.BatteryStatus;
import com.lxisoft.emergencyalert.repository.BatteryStatusRepository;
import com.lxisoft.emergencyalert.service.dto.BatteryStatusDTO;
import com.lxisoft.emergencyalert.service.mapper.BatteryStatusMapper;
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
 * Integration tests for the {@link BatteryStatusResource} REST controller.
 */
@IntegrationTest
@AutoConfigureMockMvc
@WithMockUser
class BatteryStatusResourceIT {

    private static final Integer DEFAULT_BATTERY_LEVEL = 1;
    private static final Integer UPDATED_BATTERY_LEVEL = 2;

    private static final String ENTITY_API_URL = "/api/battery-statuses";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private ObjectMapper om;

    @Autowired
    private BatteryStatusRepository batteryStatusRepository;

    @Autowired
    private BatteryStatusMapper batteryStatusMapper;

    @Autowired
    private EntityManager em;

    @Autowired
    private MockMvc restBatteryStatusMockMvc;

    private BatteryStatus batteryStatus;

    private BatteryStatus insertedBatteryStatus;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static BatteryStatus createEntity() {
        return new BatteryStatus().batteryLevel(DEFAULT_BATTERY_LEVEL);
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static BatteryStatus createUpdatedEntity() {
        return new BatteryStatus().batteryLevel(UPDATED_BATTERY_LEVEL);
    }

    @BeforeEach
    public void initTest() {
        batteryStatus = createEntity();
    }

    @AfterEach
    public void cleanup() {
        if (insertedBatteryStatus != null) {
            batteryStatusRepository.delete(insertedBatteryStatus);
            insertedBatteryStatus = null;
        }
    }

    @Test
    @Transactional
    void createBatteryStatus() throws Exception {
        long databaseSizeBeforeCreate = getRepositoryCount();
        // Create the BatteryStatus
        BatteryStatusDTO batteryStatusDTO = batteryStatusMapper.toDto(batteryStatus);
        var returnedBatteryStatusDTO = om.readValue(
            restBatteryStatusMockMvc
                .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(batteryStatusDTO)))
                .andExpect(status().isCreated())
                .andReturn()
                .getResponse()
                .getContentAsString(),
            BatteryStatusDTO.class
        );

        // Validate the BatteryStatus in the database
        assertIncrementedRepositoryCount(databaseSizeBeforeCreate);
        var returnedBatteryStatus = batteryStatusMapper.toEntity(returnedBatteryStatusDTO);
        assertBatteryStatusUpdatableFieldsEquals(returnedBatteryStatus, getPersistedBatteryStatus(returnedBatteryStatus));

        insertedBatteryStatus = returnedBatteryStatus;
    }

    @Test
    @Transactional
    void createBatteryStatusWithExistingId() throws Exception {
        // Create the BatteryStatus with an existing ID
        batteryStatus.setId(1L);
        BatteryStatusDTO batteryStatusDTO = batteryStatusMapper.toDto(batteryStatus);

        long databaseSizeBeforeCreate = getRepositoryCount();

        // An entity with an existing ID cannot be created, so this API call must fail
        restBatteryStatusMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(batteryStatusDTO)))
            .andExpect(status().isBadRequest());

        // Validate the BatteryStatus in the database
        assertSameRepositoryCount(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    void checkBatteryLevelIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        batteryStatus.setBatteryLevel(null);

        // Create the BatteryStatus, which fails.
        BatteryStatusDTO batteryStatusDTO = batteryStatusMapper.toDto(batteryStatus);

        restBatteryStatusMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(batteryStatusDTO)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void getAllBatteryStatuses() throws Exception {
        // Initialize the database
        insertedBatteryStatus = batteryStatusRepository.saveAndFlush(batteryStatus);

        // Get all the batteryStatusList
        restBatteryStatusMockMvc
            .perform(get(ENTITY_API_URL + "?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(batteryStatus.getId().intValue())))
            .andExpect(jsonPath("$.[*].batteryLevel").value(hasItem(DEFAULT_BATTERY_LEVEL)));
    }

    @Test
    @Transactional
    void getBatteryStatus() throws Exception {
        // Initialize the database
        insertedBatteryStatus = batteryStatusRepository.saveAndFlush(batteryStatus);

        // Get the batteryStatus
        restBatteryStatusMockMvc
            .perform(get(ENTITY_API_URL_ID, batteryStatus.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.id").value(batteryStatus.getId().intValue()))
            .andExpect(jsonPath("$.batteryLevel").value(DEFAULT_BATTERY_LEVEL));
    }

    @Test
    @Transactional
    void getNonExistingBatteryStatus() throws Exception {
        // Get the batteryStatus
        restBatteryStatusMockMvc.perform(get(ENTITY_API_URL_ID, Long.MAX_VALUE)).andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    void putExistingBatteryStatus() throws Exception {
        // Initialize the database
        insertedBatteryStatus = batteryStatusRepository.saveAndFlush(batteryStatus);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the batteryStatus
        BatteryStatus updatedBatteryStatus = batteryStatusRepository.findById(batteryStatus.getId()).orElseThrow();
        // Disconnect from session so that the updates on updatedBatteryStatus are not directly saved in db
        em.detach(updatedBatteryStatus);
        updatedBatteryStatus.batteryLevel(UPDATED_BATTERY_LEVEL);
        BatteryStatusDTO batteryStatusDTO = batteryStatusMapper.toDto(updatedBatteryStatus);

        restBatteryStatusMockMvc
            .perform(
                put(ENTITY_API_URL_ID, batteryStatusDTO.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(batteryStatusDTO))
            )
            .andExpect(status().isOk());

        // Validate the BatteryStatus in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPersistedBatteryStatusToMatchAllProperties(updatedBatteryStatus);
    }

    @Test
    @Transactional
    void putNonExistingBatteryStatus() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        batteryStatus.setId(longCount.incrementAndGet());

        // Create the BatteryStatus
        BatteryStatusDTO batteryStatusDTO = batteryStatusMapper.toDto(batteryStatus);

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restBatteryStatusMockMvc
            .perform(
                put(ENTITY_API_URL_ID, batteryStatusDTO.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(batteryStatusDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the BatteryStatus in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithIdMismatchBatteryStatus() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        batteryStatus.setId(longCount.incrementAndGet());

        // Create the BatteryStatus
        BatteryStatusDTO batteryStatusDTO = batteryStatusMapper.toDto(batteryStatus);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restBatteryStatusMockMvc
            .perform(
                put(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(batteryStatusDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the BatteryStatus in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithMissingIdPathParamBatteryStatus() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        batteryStatus.setId(longCount.incrementAndGet());

        // Create the BatteryStatus
        BatteryStatusDTO batteryStatusDTO = batteryStatusMapper.toDto(batteryStatus);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restBatteryStatusMockMvc
            .perform(put(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(batteryStatusDTO)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the BatteryStatus in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void partialUpdateBatteryStatusWithPatch() throws Exception {
        // Initialize the database
        insertedBatteryStatus = batteryStatusRepository.saveAndFlush(batteryStatus);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the batteryStatus using partial update
        BatteryStatus partialUpdatedBatteryStatus = new BatteryStatus();
        partialUpdatedBatteryStatus.setId(batteryStatus.getId());

        restBatteryStatusMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedBatteryStatus.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedBatteryStatus))
            )
            .andExpect(status().isOk());

        // Validate the BatteryStatus in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertBatteryStatusUpdatableFieldsEquals(
            createUpdateProxyForBean(partialUpdatedBatteryStatus, batteryStatus),
            getPersistedBatteryStatus(batteryStatus)
        );
    }

    @Test
    @Transactional
    void fullUpdateBatteryStatusWithPatch() throws Exception {
        // Initialize the database
        insertedBatteryStatus = batteryStatusRepository.saveAndFlush(batteryStatus);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the batteryStatus using partial update
        BatteryStatus partialUpdatedBatteryStatus = new BatteryStatus();
        partialUpdatedBatteryStatus.setId(batteryStatus.getId());

        partialUpdatedBatteryStatus.batteryLevel(UPDATED_BATTERY_LEVEL);

        restBatteryStatusMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedBatteryStatus.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedBatteryStatus))
            )
            .andExpect(status().isOk());

        // Validate the BatteryStatus in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertBatteryStatusUpdatableFieldsEquals(partialUpdatedBatteryStatus, getPersistedBatteryStatus(partialUpdatedBatteryStatus));
    }

    @Test
    @Transactional
    void patchNonExistingBatteryStatus() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        batteryStatus.setId(longCount.incrementAndGet());

        // Create the BatteryStatus
        BatteryStatusDTO batteryStatusDTO = batteryStatusMapper.toDto(batteryStatus);

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restBatteryStatusMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, batteryStatusDTO.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(batteryStatusDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the BatteryStatus in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithIdMismatchBatteryStatus() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        batteryStatus.setId(longCount.incrementAndGet());

        // Create the BatteryStatus
        BatteryStatusDTO batteryStatusDTO = batteryStatusMapper.toDto(batteryStatus);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restBatteryStatusMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(batteryStatusDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the BatteryStatus in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithMissingIdPathParamBatteryStatus() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        batteryStatus.setId(longCount.incrementAndGet());

        // Create the BatteryStatus
        BatteryStatusDTO batteryStatusDTO = batteryStatusMapper.toDto(batteryStatus);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restBatteryStatusMockMvc
            .perform(patch(ENTITY_API_URL).contentType("application/merge-patch+json").content(om.writeValueAsBytes(batteryStatusDTO)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the BatteryStatus in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void deleteBatteryStatus() throws Exception {
        // Initialize the database
        insertedBatteryStatus = batteryStatusRepository.saveAndFlush(batteryStatus);

        long databaseSizeBeforeDelete = getRepositoryCount();

        // Delete the batteryStatus
        restBatteryStatusMockMvc
            .perform(delete(ENTITY_API_URL_ID, batteryStatus.getId()).accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isNoContent());

        // Validate the database contains one less item
        assertDecrementedRepositoryCount(databaseSizeBeforeDelete);
    }

    protected long getRepositoryCount() {
        return batteryStatusRepository.count();
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

    protected BatteryStatus getPersistedBatteryStatus(BatteryStatus batteryStatus) {
        return batteryStatusRepository.findById(batteryStatus.getId()).orElseThrow();
    }

    protected void assertPersistedBatteryStatusToMatchAllProperties(BatteryStatus expectedBatteryStatus) {
        assertBatteryStatusAllPropertiesEquals(expectedBatteryStatus, getPersistedBatteryStatus(expectedBatteryStatus));
    }

    protected void assertPersistedBatteryStatusToMatchUpdatableProperties(BatteryStatus expectedBatteryStatus) {
        assertBatteryStatusAllUpdatablePropertiesEquals(expectedBatteryStatus, getPersistedBatteryStatus(expectedBatteryStatus));
    }
}
