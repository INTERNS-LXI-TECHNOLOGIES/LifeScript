package com.diviso.habittrackbackend.web.rest;

import static com.diviso.habittrackbackend.domain.HabitTrackAsserts.*;
import static com.diviso.habittrackbackend.web.rest.TestUtil.createUpdateProxyForBean;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.is;

import com.diviso.habittrackbackend.IntegrationTest;
import com.diviso.habittrackbackend.domain.HabitTrack;
import com.diviso.habittrackbackend.repository.EntityManager;
import com.diviso.habittrackbackend.repository.HabitTrackRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.time.Duration;
import java.util.List;
import java.util.Random;
import java.util.concurrent.atomic.AtomicLong;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.reactive.AutoConfigureWebTestClient;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.reactive.server.WebTestClient;

/**
 * Integration tests for the {@link HabitTrackResource} REST controller.
 */
@IntegrationTest
@AutoConfigureWebTestClient(timeout = IntegrationTest.DEFAULT_ENTITY_TIMEOUT)
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
    private WebTestClient webTestClient;

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

    public static void deleteEntities(EntityManager em) {
        try {
            em.deleteAll(HabitTrack.class).block();
        } catch (Exception e) {
            // It can fail, if other entities are still referring this - it will be removed later.
        }
    }

    @BeforeEach
    public void initTest() {
        habitTrack = createEntity();
    }

    @AfterEach
    public void cleanup() {
        if (insertedHabitTrack != null) {
            habitTrackRepository.delete(insertedHabitTrack).block();
            insertedHabitTrack = null;
        }
        deleteEntities(em);
    }

    @Test
    void createHabitTrack() throws Exception {
        long databaseSizeBeforeCreate = getRepositoryCount();
        // Create the HabitTrack
        var returnedHabitTrack = webTestClient
            .post()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(habitTrack))
            .exchange()
            .expectStatus()
            .isCreated()
            .expectBody(HabitTrack.class)
            .returnResult()
            .getResponseBody();

        // Validate the HabitTrack in the database
        assertIncrementedRepositoryCount(databaseSizeBeforeCreate);
        assertHabitTrackUpdatableFieldsEquals(returnedHabitTrack, getPersistedHabitTrack(returnedHabitTrack));

        insertedHabitTrack = returnedHabitTrack;
    }

    @Test
    void createHabitTrackWithExistingId() throws Exception {
        // Create the HabitTrack with an existing ID
        habitTrack.setId(1L);

        long databaseSizeBeforeCreate = getRepositoryCount();

        // An entity with an existing ID cannot be created, so this API call must fail
        webTestClient
            .post()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(habitTrack))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeCreate);
    }

    @Test
    void getAllHabitTracksAsStream() {
        // Initialize the database
        habitTrackRepository.save(habitTrack).block();

        List<HabitTrack> habitTrackList = webTestClient
            .get()
            .uri(ENTITY_API_URL)
            .accept(MediaType.APPLICATION_NDJSON)
            .exchange()
            .expectStatus()
            .isOk()
            .expectHeader()
            .contentTypeCompatibleWith(MediaType.APPLICATION_NDJSON)
            .returnResult(HabitTrack.class)
            .getResponseBody()
            .filter(habitTrack::equals)
            .collectList()
            .block(Duration.ofSeconds(5));

        assertThat(habitTrackList).isNotNull();
        assertThat(habitTrackList).hasSize(1);
        HabitTrack testHabitTrack = habitTrackList.get(0);

        // Test fails because reactive api returns an empty object instead of null
        // assertHabitTrackAllPropertiesEquals(habitTrack, testHabitTrack);
        assertHabitTrackUpdatableFieldsEquals(habitTrack, testHabitTrack);
    }

    @Test
    void getAllHabitTracks() {
        // Initialize the database
        insertedHabitTrack = habitTrackRepository.save(habitTrack).block();

        // Get all the habitTrackList
        webTestClient
            .get()
            .uri(ENTITY_API_URL + "?sort=id,desc")
            .accept(MediaType.APPLICATION_JSON)
            .exchange()
            .expectStatus()
            .isOk()
            .expectHeader()
            .contentType(MediaType.APPLICATION_JSON)
            .expectBody()
            .jsonPath("$.[*].id")
            .value(hasItem(habitTrack.getId().intValue()))
            .jsonPath("$.[*].habitId")
            .value(hasItem(DEFAULT_HABIT_ID))
            .jsonPath("$.[*].habitName")
            .value(hasItem(DEFAULT_HABIT_NAME))
            .jsonPath("$.[*].description")
            .value(hasItem(DEFAULT_DESCRIPTION))
            .jsonPath("$.[*].category")
            .value(hasItem(DEFAULT_CATEGORY))
            .jsonPath("$.[*].startDate")
            .value(hasItem(DEFAULT_START_DATE))
            .jsonPath("$.[*].endDate")
            .value(hasItem(DEFAULT_END_DATE));
    }

    @Test
    void getHabitTrack() {
        // Initialize the database
        insertedHabitTrack = habitTrackRepository.save(habitTrack).block();

        // Get the habitTrack
        webTestClient
            .get()
            .uri(ENTITY_API_URL_ID, habitTrack.getId())
            .accept(MediaType.APPLICATION_JSON)
            .exchange()
            .expectStatus()
            .isOk()
            .expectHeader()
            .contentType(MediaType.APPLICATION_JSON)
            .expectBody()
            .jsonPath("$.id")
            .value(is(habitTrack.getId().intValue()))
            .jsonPath("$.habitId")
            .value(is(DEFAULT_HABIT_ID))
            .jsonPath("$.habitName")
            .value(is(DEFAULT_HABIT_NAME))
            .jsonPath("$.description")
            .value(is(DEFAULT_DESCRIPTION))
            .jsonPath("$.category")
            .value(is(DEFAULT_CATEGORY))
            .jsonPath("$.startDate")
            .value(is(DEFAULT_START_DATE))
            .jsonPath("$.endDate")
            .value(is(DEFAULT_END_DATE));
    }

    @Test
    void getNonExistingHabitTrack() {
        // Get the habitTrack
        webTestClient
            .get()
            .uri(ENTITY_API_URL_ID, Long.MAX_VALUE)
            .accept(MediaType.APPLICATION_PROBLEM_JSON)
            .exchange()
            .expectStatus()
            .isNotFound();
    }

    @Test
    void putExistingHabitTrack() throws Exception {
        // Initialize the database
        insertedHabitTrack = habitTrackRepository.save(habitTrack).block();

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the habitTrack
        HabitTrack updatedHabitTrack = habitTrackRepository.findById(habitTrack.getId()).block();
        updatedHabitTrack
            .habitId(UPDATED_HABIT_ID)
            .habitName(UPDATED_HABIT_NAME)
            .description(UPDATED_DESCRIPTION)
            .category(UPDATED_CATEGORY)
            .startDate(UPDATED_START_DATE)
            .endDate(UPDATED_END_DATE);

        webTestClient
            .put()
            .uri(ENTITY_API_URL_ID, updatedHabitTrack.getId())
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(updatedHabitTrack))
            .exchange()
            .expectStatus()
            .isOk();

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPersistedHabitTrackToMatchAllProperties(updatedHabitTrack);
    }

    @Test
    void putNonExistingHabitTrack() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        habitTrack.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        webTestClient
            .put()
            .uri(ENTITY_API_URL_ID, habitTrack.getId())
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(habitTrack))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void putWithIdMismatchHabitTrack() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        habitTrack.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .put()
            .uri(ENTITY_API_URL_ID, longCount.incrementAndGet())
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(habitTrack))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void putWithMissingIdPathParamHabitTrack() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        habitTrack.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .put()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(habitTrack))
            .exchange()
            .expectStatus()
            .isEqualTo(405);

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void partialUpdateHabitTrackWithPatch() throws Exception {
        // Initialize the database
        insertedHabitTrack = habitTrackRepository.save(habitTrack).block();

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the habitTrack using partial update
        HabitTrack partialUpdatedHabitTrack = new HabitTrack();
        partialUpdatedHabitTrack.setId(habitTrack.getId());

        partialUpdatedHabitTrack.habitName(UPDATED_HABIT_NAME).description(UPDATED_DESCRIPTION).endDate(UPDATED_END_DATE);

        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, partialUpdatedHabitTrack.getId())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(partialUpdatedHabitTrack))
            .exchange()
            .expectStatus()
            .isOk();

        // Validate the HabitTrack in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertHabitTrackUpdatableFieldsEquals(
            createUpdateProxyForBean(partialUpdatedHabitTrack, habitTrack),
            getPersistedHabitTrack(habitTrack)
        );
    }

    @Test
    void fullUpdateHabitTrackWithPatch() throws Exception {
        // Initialize the database
        insertedHabitTrack = habitTrackRepository.save(habitTrack).block();

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

        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, partialUpdatedHabitTrack.getId())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(partialUpdatedHabitTrack))
            .exchange()
            .expectStatus()
            .isOk();

        // Validate the HabitTrack in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertHabitTrackUpdatableFieldsEquals(partialUpdatedHabitTrack, getPersistedHabitTrack(partialUpdatedHabitTrack));
    }

    @Test
    void patchNonExistingHabitTrack() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        habitTrack.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, habitTrack.getId())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(habitTrack))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void patchWithIdMismatchHabitTrack() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        habitTrack.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, longCount.incrementAndGet())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(habitTrack))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void patchWithMissingIdPathParamHabitTrack() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        habitTrack.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .patch()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(habitTrack))
            .exchange()
            .expectStatus()
            .isEqualTo(405);

        // Validate the HabitTrack in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void deleteHabitTrack() {
        // Initialize the database
        insertedHabitTrack = habitTrackRepository.save(habitTrack).block();

        long databaseSizeBeforeDelete = getRepositoryCount();

        // Delete the habitTrack
        webTestClient
            .delete()
            .uri(ENTITY_API_URL_ID, habitTrack.getId())
            .accept(MediaType.APPLICATION_JSON)
            .exchange()
            .expectStatus()
            .isNoContent();

        // Validate the database contains one less item
        assertDecrementedRepositoryCount(databaseSizeBeforeDelete);
    }

    protected long getRepositoryCount() {
        return habitTrackRepository.count().block();
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
        return habitTrackRepository.findById(habitTrack.getId()).block();
    }

    protected void assertPersistedHabitTrackToMatchAllProperties(HabitTrack expectedHabitTrack) {
        // Test fails because reactive api returns an empty object instead of null
        // assertHabitTrackAllPropertiesEquals(expectedHabitTrack, getPersistedHabitTrack(expectedHabitTrack));
        assertHabitTrackUpdatableFieldsEquals(expectedHabitTrack, getPersistedHabitTrack(expectedHabitTrack));
    }

    protected void assertPersistedHabitTrackToMatchUpdatableProperties(HabitTrack expectedHabitTrack) {
        // Test fails because reactive api returns an empty object instead of null
        // assertHabitTrackAllUpdatablePropertiesEquals(expectedHabitTrack, getPersistedHabitTrack(expectedHabitTrack));
        assertHabitTrackUpdatableFieldsEquals(expectedHabitTrack, getPersistedHabitTrack(expectedHabitTrack));
    }
}
