package com.lxisoft.emergencyalert.web.rest;

import static com.lxisoft.emergencyalert.domain.EmergencyContactAsserts.*;
import static com.lxisoft.emergencyalert.web.rest.TestUtil.createUpdateProxyForBean;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lxisoft.emergencyalert.IntegrationTest;
import com.lxisoft.emergencyalert.domain.EmergencyContact;
import com.lxisoft.emergencyalert.repository.EmergencyContactRepository;
import com.lxisoft.emergencyalert.service.dto.EmergencyContactDTO;
import com.lxisoft.emergencyalert.service.mapper.EmergencyContactMapper;
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
 * Integration tests for the {@link EmergencyContactResource} REST controller.
 */
@IntegrationTest
@AutoConfigureMockMvc
@WithMockUser
class EmergencyContactResourceIT {

    private static final String DEFAULT_NAME = "AAAAAAAAAA";
    private static final String UPDATED_NAME = "BBBBBBBBBB";

    private static final String DEFAULT_TYPE = "AAAAAAAAAA";
    private static final String UPDATED_TYPE = "BBBBBBBBBB";

    private static final String DEFAULT_PHONE_NUMBER = "AAAAAAAAAA";
    private static final String UPDATED_PHONE_NUMBER = "BBBBBBBBBB";

    private static final String ENTITY_API_URL = "/api/emergency-contacts";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private ObjectMapper om;

    @Autowired
    private EmergencyContactRepository emergencyContactRepository;

    @Autowired
    private EmergencyContactMapper emergencyContactMapper;

    @Autowired
    private EntityManager em;

    @Autowired
    private MockMvc restEmergencyContactMockMvc;

    private EmergencyContact emergencyContact;

    private EmergencyContact insertedEmergencyContact;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static EmergencyContact createEntity() {
        return new EmergencyContact().name(DEFAULT_NAME).type(DEFAULT_TYPE).phoneNumber(DEFAULT_PHONE_NUMBER);
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static EmergencyContact createUpdatedEntity() {
        return new EmergencyContact().name(UPDATED_NAME).type(UPDATED_TYPE).phoneNumber(UPDATED_PHONE_NUMBER);
    }

    @BeforeEach
    public void initTest() {
        emergencyContact = createEntity();
    }

    @AfterEach
    public void cleanup() {
        if (insertedEmergencyContact != null) {
            emergencyContactRepository.delete(insertedEmergencyContact);
            insertedEmergencyContact = null;
        }
    }

    @Test
    @Transactional
    void createEmergencyContact() throws Exception {
        long databaseSizeBeforeCreate = getRepositoryCount();
        // Create the EmergencyContact
        EmergencyContactDTO emergencyContactDTO = emergencyContactMapper.toDto(emergencyContact);
        var returnedEmergencyContactDTO = om.readValue(
            restEmergencyContactMockMvc
                .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(emergencyContactDTO)))
                .andExpect(status().isCreated())
                .andReturn()
                .getResponse()
                .getContentAsString(),
            EmergencyContactDTO.class
        );

        // Validate the EmergencyContact in the database
        assertIncrementedRepositoryCount(databaseSizeBeforeCreate);
        var returnedEmergencyContact = emergencyContactMapper.toEntity(returnedEmergencyContactDTO);
        assertEmergencyContactUpdatableFieldsEquals(returnedEmergencyContact, getPersistedEmergencyContact(returnedEmergencyContact));

        insertedEmergencyContact = returnedEmergencyContact;
    }

    @Test
    @Transactional
    void createEmergencyContactWithExistingId() throws Exception {
        // Create the EmergencyContact with an existing ID
        emergencyContact.setId(1L);
        EmergencyContactDTO emergencyContactDTO = emergencyContactMapper.toDto(emergencyContact);

        long databaseSizeBeforeCreate = getRepositoryCount();

        // An entity with an existing ID cannot be created, so this API call must fail
        restEmergencyContactMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(emergencyContactDTO)))
            .andExpect(status().isBadRequest());

        // Validate the EmergencyContact in the database
        assertSameRepositoryCount(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    void checkNameIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        emergencyContact.setName(null);

        // Create the EmergencyContact, which fails.
        EmergencyContactDTO emergencyContactDTO = emergencyContactMapper.toDto(emergencyContact);

        restEmergencyContactMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(emergencyContactDTO)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void checkTypeIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        emergencyContact.setType(null);

        // Create the EmergencyContact, which fails.
        EmergencyContactDTO emergencyContactDTO = emergencyContactMapper.toDto(emergencyContact);

        restEmergencyContactMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(emergencyContactDTO)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void checkPhoneNumberIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        emergencyContact.setPhoneNumber(null);

        // Create the EmergencyContact, which fails.
        EmergencyContactDTO emergencyContactDTO = emergencyContactMapper.toDto(emergencyContact);

        restEmergencyContactMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(emergencyContactDTO)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void getAllEmergencyContacts() throws Exception {
        // Initialize the database
        insertedEmergencyContact = emergencyContactRepository.saveAndFlush(emergencyContact);

        // Get all the emergencyContactList
        restEmergencyContactMockMvc
            .perform(get(ENTITY_API_URL + "?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(emergencyContact.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME)))
            .andExpect(jsonPath("$.[*].type").value(hasItem(DEFAULT_TYPE)))
            .andExpect(jsonPath("$.[*].phoneNumber").value(hasItem(DEFAULT_PHONE_NUMBER)));
    }

    @Test
    @Transactional
    void getEmergencyContact() throws Exception {
        // Initialize the database
        insertedEmergencyContact = emergencyContactRepository.saveAndFlush(emergencyContact);

        // Get the emergencyContact
        restEmergencyContactMockMvc
            .perform(get(ENTITY_API_URL_ID, emergencyContact.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.id").value(emergencyContact.getId().intValue()))
            .andExpect(jsonPath("$.name").value(DEFAULT_NAME))
            .andExpect(jsonPath("$.type").value(DEFAULT_TYPE))
            .andExpect(jsonPath("$.phoneNumber").value(DEFAULT_PHONE_NUMBER));
    }

    @Test
    @Transactional
    void getNonExistingEmergencyContact() throws Exception {
        // Get the emergencyContact
        restEmergencyContactMockMvc.perform(get(ENTITY_API_URL_ID, Long.MAX_VALUE)).andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    void putExistingEmergencyContact() throws Exception {
        // Initialize the database
        insertedEmergencyContact = emergencyContactRepository.saveAndFlush(emergencyContact);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the emergencyContact
        EmergencyContact updatedEmergencyContact = emergencyContactRepository.findById(emergencyContact.getId()).orElseThrow();
        // Disconnect from session so that the updates on updatedEmergencyContact are not directly saved in db
        em.detach(updatedEmergencyContact);
        updatedEmergencyContact.name(UPDATED_NAME).type(UPDATED_TYPE).phoneNumber(UPDATED_PHONE_NUMBER);
        EmergencyContactDTO emergencyContactDTO = emergencyContactMapper.toDto(updatedEmergencyContact);

        restEmergencyContactMockMvc
            .perform(
                put(ENTITY_API_URL_ID, emergencyContactDTO.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(emergencyContactDTO))
            )
            .andExpect(status().isOk());

        // Validate the EmergencyContact in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPersistedEmergencyContactToMatchAllProperties(updatedEmergencyContact);
    }

    @Test
    @Transactional
    void putNonExistingEmergencyContact() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        emergencyContact.setId(longCount.incrementAndGet());

        // Create the EmergencyContact
        EmergencyContactDTO emergencyContactDTO = emergencyContactMapper.toDto(emergencyContact);

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restEmergencyContactMockMvc
            .perform(
                put(ENTITY_API_URL_ID, emergencyContactDTO.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(emergencyContactDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the EmergencyContact in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithIdMismatchEmergencyContact() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        emergencyContact.setId(longCount.incrementAndGet());

        // Create the EmergencyContact
        EmergencyContactDTO emergencyContactDTO = emergencyContactMapper.toDto(emergencyContact);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restEmergencyContactMockMvc
            .perform(
                put(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(emergencyContactDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the EmergencyContact in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithMissingIdPathParamEmergencyContact() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        emergencyContact.setId(longCount.incrementAndGet());

        // Create the EmergencyContact
        EmergencyContactDTO emergencyContactDTO = emergencyContactMapper.toDto(emergencyContact);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restEmergencyContactMockMvc
            .perform(put(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(emergencyContactDTO)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the EmergencyContact in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void partialUpdateEmergencyContactWithPatch() throws Exception {
        // Initialize the database
        insertedEmergencyContact = emergencyContactRepository.saveAndFlush(emergencyContact);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the emergencyContact using partial update
        EmergencyContact partialUpdatedEmergencyContact = new EmergencyContact();
        partialUpdatedEmergencyContact.setId(emergencyContact.getId());

        partialUpdatedEmergencyContact.name(UPDATED_NAME).phoneNumber(UPDATED_PHONE_NUMBER);

        restEmergencyContactMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedEmergencyContact.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedEmergencyContact))
            )
            .andExpect(status().isOk());

        // Validate the EmergencyContact in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertEmergencyContactUpdatableFieldsEquals(
            createUpdateProxyForBean(partialUpdatedEmergencyContact, emergencyContact),
            getPersistedEmergencyContact(emergencyContact)
        );
    }

    @Test
    @Transactional
    void fullUpdateEmergencyContactWithPatch() throws Exception {
        // Initialize the database
        insertedEmergencyContact = emergencyContactRepository.saveAndFlush(emergencyContact);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the emergencyContact using partial update
        EmergencyContact partialUpdatedEmergencyContact = new EmergencyContact();
        partialUpdatedEmergencyContact.setId(emergencyContact.getId());

        partialUpdatedEmergencyContact.name(UPDATED_NAME).type(UPDATED_TYPE).phoneNumber(UPDATED_PHONE_NUMBER);

        restEmergencyContactMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedEmergencyContact.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedEmergencyContact))
            )
            .andExpect(status().isOk());

        // Validate the EmergencyContact in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertEmergencyContactUpdatableFieldsEquals(
            partialUpdatedEmergencyContact,
            getPersistedEmergencyContact(partialUpdatedEmergencyContact)
        );
    }

    @Test
    @Transactional
    void patchNonExistingEmergencyContact() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        emergencyContact.setId(longCount.incrementAndGet());

        // Create the EmergencyContact
        EmergencyContactDTO emergencyContactDTO = emergencyContactMapper.toDto(emergencyContact);

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restEmergencyContactMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, emergencyContactDTO.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(emergencyContactDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the EmergencyContact in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithIdMismatchEmergencyContact() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        emergencyContact.setId(longCount.incrementAndGet());

        // Create the EmergencyContact
        EmergencyContactDTO emergencyContactDTO = emergencyContactMapper.toDto(emergencyContact);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restEmergencyContactMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(emergencyContactDTO))
            )
            .andExpect(status().isBadRequest());

        // Validate the EmergencyContact in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithMissingIdPathParamEmergencyContact() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        emergencyContact.setId(longCount.incrementAndGet());

        // Create the EmergencyContact
        EmergencyContactDTO emergencyContactDTO = emergencyContactMapper.toDto(emergencyContact);

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restEmergencyContactMockMvc
            .perform(patch(ENTITY_API_URL).contentType("application/merge-patch+json").content(om.writeValueAsBytes(emergencyContactDTO)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the EmergencyContact in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void deleteEmergencyContact() throws Exception {
        // Initialize the database
        insertedEmergencyContact = emergencyContactRepository.saveAndFlush(emergencyContact);

        long databaseSizeBeforeDelete = getRepositoryCount();

        // Delete the emergencyContact
        restEmergencyContactMockMvc
            .perform(delete(ENTITY_API_URL_ID, emergencyContact.getId()).accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isNoContent());

        // Validate the database contains one less item
        assertDecrementedRepositoryCount(databaseSizeBeforeDelete);
    }

    protected long getRepositoryCount() {
        return emergencyContactRepository.count();
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

    protected EmergencyContact getPersistedEmergencyContact(EmergencyContact emergencyContact) {
        return emergencyContactRepository.findById(emergencyContact.getId()).orElseThrow();
    }

    protected void assertPersistedEmergencyContactToMatchAllProperties(EmergencyContact expectedEmergencyContact) {
        assertEmergencyContactAllPropertiesEquals(expectedEmergencyContact, getPersistedEmergencyContact(expectedEmergencyContact));
    }

    protected void assertPersistedEmergencyContactToMatchUpdatableProperties(EmergencyContact expectedEmergencyContact) {
        assertEmergencyContactAllUpdatablePropertiesEquals(
            expectedEmergencyContact,
            getPersistedEmergencyContact(expectedEmergencyContact)
        );
    }
}
