package com.lxisoft.emergencyalert.web.rest;

import static com.lxisoft.emergencyalert.domain.GeoFenceAsserts.*;
import static com.lxisoft.emergencyalert.web.rest.TestUtil.createUpdateProxyForBean;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lxisoft.emergencyalert.IntegrationTest;
import com.lxisoft.emergencyalert.domain.GeoFence;
import com.lxisoft.emergencyalert.repository.GeoFenceRepository;
import com.lxisoft.emergencyalert.service.dto.GeoFenceDTO;
import com.lxisoft.emergencyalert.service.mapper.GeoFenceMapper;
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
 * Integration tests for the {@link GeoFenceResource} REST controller.
 */
@IntegrationTest
@AutoConfigureMockMvc
@WithMockUser
class GeoFenceResourceIT {

    private static final String DEFAULT_SAFE_ZONES = "AAAAAAAAAA";
    private static final String UPDATED_SAFE_ZONES = "BBBBBBBBBB";

    private static final String ENTITY_API_URL = "/api/geo-fences";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private ObjectMapper om;

    @Autowired
    private GeoFenceRepository geoFenceRepository;

    @Autowired
    private GeoFenceMapper geoFenceMapper;

    @Autowired
    private EntityManager em;

    @Autowired
    private MockMvc restGeoFenceMockMvc;

    private GeoFence geoFence;

    private GeoFence insertedGeoFence;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static GeoFence createEntity() {
        return new GeoFence().safeZones(DEFAULT_SAFE_ZONES);
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static GeoFence createUpdatedEntity() {
        return new GeoFence().safeZones(UPDATED_SAFE_ZONES);
    }

    @BeforeEach
    public void initTest() {
        geoFence = createEntity();
    }

    @AfterEach
    public void cleanup() {
        if (insertedGeoFence != null) {
            geoFenceRepository.delete(insertedGeoFence);
            insertedGeoFence = null;
        }
    }

    @Test
    @Transactional
    void createGeoFence() throws Exception {
        long databaseSizeBeforeCreate = getRepositoryCount();
        // Create the GeoFence
        GeoFenceDTO geoFenceDTO = geoFenceMapper.toDto(geoFence);
        var returnedGeoFenceDTO = om.readValue(
            restGeoFenceMockMvc
                .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(geoFenceDTO)))
                .andExpect(status().isCreated())
                .andReturn()
                .getResponse()
                .getContentAsString(),
            GeoFenceDTO.class
        );

        // Validate the GeoFence in the database
        assertIncrementedRepositoryCount(databaseSizeBeforeCreate);
        var returnedGeoFence = geoFenceMapper.toEntity(returnedGeoFenceDTO);
        assertGeoFenceUpdatableFieldsEquals(returnedGeoFence, getPersistedGeoFence(returnedGeoFence));

        insertedGeoFence = returnedGeoFence;
    }

    @Test
    @Transactional
    void createGeoFenceWithExistingId() throws Exception {
        // Create the GeoFence with an existing ID
        geoFence.setId(1L);
        GeoFenceDTO geoFenceDTO = geoFenceMapper.toDto(geoFence);

        long databaseSizeBeforeCreate = getRepositoryCount();

        // An entity with an existing ID cannot be created, so this API call must fail
        restGeoFenceMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(geoFenceDTO)))
            .andExpect(status().isBadRequest());

        // Validate the GeoFence in the database
        assertSameRepositoryCount(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    void checkSafeZonesIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        geoFence.setSafeZones(null);

        // Create the GeoFence, which fails.
        GeoFenceDTO geoFenceDTO = geoFenceMapper.toDto(geoFence);

        restGeoFenceMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(geoFenceDTO)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void getAllGeoFences() throws Exception {
        // Initialize the database
        insertedGeoFence = geoFenceRepository.saveAndFlush(geoFence);

        // Get all the geoFenceList
        restGeoFenceMockMvc
            .perform(get(ENTITY_API_URL + "?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(geoFence.getId().intValue())))
            .andExpect(jsonPath("$.[*].safeZones").value(hasItem(DEFAULT_SAFE_ZONES)));
    }

    @Test
    @Transactional
    void getGeoFence() throws Exception {
        // Initialize the database
        insertedGeoFence = geoFenceRepository.saveAndFlush(geoFence);

        // Get the geoFence
        restGeoFenceMockMvc
            .perform(get(ENTITY_API_URL_ID, geoFence.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.id").value(geoFence.getId().intValue()))
            .andExpect(jsonPath("$.safeZones").value(DEFAULT_SAFE_ZONES));
    }

    @Test
    @Transactional
    void getNonExistingGeoFence() throws Exception {
        // Get the geoFence
        restGeoFenceMockMvc.perform(get(ENTITY_API_URL_ID, Long.MAX_VALUE)).andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    void putExistingGeoFence() throws Exception {
        // Initialize the database
        insertedGeoFence = geoFenceRepository.saveAndFlush(geoFence);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the geoFence
        GeoFence updatedGeoFence = geoFenceRepository.findById(geoFence.getId()).orElseThrow();
        // Disconnect from session so that the updates on updatedGeoFence are not directly saved in db
        em.detach(updatedGeoFence);
        updatedGeoFence.safeZones(UPDATED_SAFE_ZONES);
        GeoFenceDTO geoFenceDTO = geoFenceMapper.toDto(updatedGeoFence);

        restGeoFenceMockMvc
            .perform(
                put(ENTITY_API_URL_ID, geoFenceDTO.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(geoFenceDTO))
            )
            .andExpect(status().isOk());

        // Validate the GeoFence in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPersistedGeoFenceToMatchAllProperties(updatedGeoFence);
    }

    @Test
    @Transactional
    void putNonExistingGeoFence() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        geoFence.setId(longCount.incrementAndGet());

        // Create the GeoFence
        GeoFenceDTO geoFenceDTO = geoFenceMapper.toDto(geoFence);

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restGeoFenceMockMvc
            .perform(
                put(ENTITY_API_URL_ID, geoFenceDTO.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(geoFenceDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the GeoFence in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithIdMismatchGeoFence() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        geoFence.setId(longCount.incrementAndGet());

        // Create the GeoFence
        GeoFenceDTO geoFenceDTO = geoFenceMapper.toDto(geoFence);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restGeoFenceMockMvc
            .perform(
                put(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(geoFenceDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the GeoFence in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithMissingIdPathParamGeoFence() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        geoFence.setId(longCount.incrementAndGet());

        // Create the GeoFence
        GeoFenceDTO geoFenceDTO = geoFenceMapper.toDto(geoFence);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restGeoFenceMockMvc
            .perform(put(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(geoFenceDTO)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the GeoFence in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void partialUpdateGeoFenceWithPatch() throws Exception {
        // Initialize the database
        insertedGeoFence = geoFenceRepository.saveAndFlush(geoFence);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the geoFence using partial update
        GeoFence partialUpdatedGeoFence = new GeoFence();
        partialUpdatedGeoFence.setId(geoFence.getId());

        restGeoFenceMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedGeoFence.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedGeoFence))
            )
            .andExpect(status().isOk());

        // Validate the GeoFence in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertGeoFenceUpdatableFieldsEquals(createUpdateProxyForBean(partialUpdatedGeoFence, geoFence), getPersistedGeoFence(geoFence));
    }

    @Test
    @Transactional
    void fullUpdateGeoFenceWithPatch() throws Exception {
        // Initialize the database
        insertedGeoFence = geoFenceRepository.saveAndFlush(geoFence);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the geoFence using partial update
        GeoFence partialUpdatedGeoFence = new GeoFence();
        partialUpdatedGeoFence.setId(geoFence.getId());

        partialUpdatedGeoFence.safeZones(UPDATED_SAFE_ZONES);

        restGeoFenceMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedGeoFence.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedGeoFence))
            )
            .andExpect(status().isOk());

        // Validate the GeoFence in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertGeoFenceUpdatableFieldsEquals(partialUpdatedGeoFence, getPersistedGeoFence(partialUpdatedGeoFence));
    }

    @Test
    @Transactional
    void patchNonExistingGeoFence() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        geoFence.setId(longCount.incrementAndGet());

        // Create the GeoFence
        GeoFenceDTO geoFenceDTO = geoFenceMapper.toDto(geoFence);

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restGeoFenceMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, geoFenceDTO.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(geoFenceDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the GeoFence in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithIdMismatchGeoFence() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        geoFence.setId(longCount.incrementAndGet());

        // Create the GeoFence
        GeoFenceDTO geoFenceDTO = geoFenceMapper.toDto(geoFence);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restGeoFenceMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(geoFenceDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the GeoFence in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithMissingIdPathParamGeoFence() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        geoFence.setId(longCount.incrementAndGet());

        // Create the GeoFence
        GeoFenceDTO geoFenceDTO = geoFenceMapper.toDto(geoFence);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restGeoFenceMockMvc
            .perform(patch(ENTITY_API_URL).contentType("application/merge-patch+json").content(om.writeValueAsBytes(geoFenceDTO)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the GeoFence in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void deleteGeoFence() throws Exception {
        // Initialize the database
        insertedGeoFence = geoFenceRepository.saveAndFlush(geoFence);

        long databaseSizeBeforeDelete = getRepositoryCount();

        // Delete the geoFence
        restGeoFenceMockMvc
            .perform(delete(ENTITY_API_URL_ID, geoFence.getId()).accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isNoContent());

        // Validate the database contains one less item
        assertDecrementedRepositoryCount(databaseSizeBeforeDelete);
    }

    protected long getRepositoryCount() {
        return geoFenceRepository.count();
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

    protected GeoFence getPersistedGeoFence(GeoFence geoFence) {
        return geoFenceRepository.findById(geoFence.getId()).orElseThrow();
    }

    protected void assertPersistedGeoFenceToMatchAllProperties(GeoFence expectedGeoFence) {
        assertGeoFenceAllPropertiesEquals(expectedGeoFence, getPersistedGeoFence(expectedGeoFence));
    }

    protected void assertPersistedGeoFenceToMatchUpdatableProperties(GeoFence expectedGeoFence) {
        assertGeoFenceAllUpdatablePropertiesEquals(expectedGeoFence, getPersistedGeoFence(expectedGeoFence));
    }
}
