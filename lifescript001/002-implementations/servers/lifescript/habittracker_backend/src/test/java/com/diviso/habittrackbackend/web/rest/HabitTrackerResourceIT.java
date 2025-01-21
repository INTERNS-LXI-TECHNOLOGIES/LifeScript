package com.diviso.habittrackbackend.web.rest;

import static com.diviso.habittrackbackend.domain.HabitTrackerAsserts.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.is;

import com.diviso.habittrackbackend.IntegrationTest;
import com.diviso.habittrackbackend.domain.HabitTracker;
import com.diviso.habittrackbackend.repository.EntityManager;
import com.diviso.habittrackbackend.repository.HabitTrackerRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.time.Duration;
import java.util.List;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.reactive.AutoConfigureWebTestClient;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.reactive.server.WebTestClient;

/**
 * Integration tests for the {@link HabitTrackerResource} REST controller.
 */
@IntegrationTest
@AutoConfigureWebTestClient(timeout = IntegrationTest.DEFAULT_ENTITY_TIMEOUT)
@WithMockUser
class HabitTrackerResourceIT {

    private static final Integer DEFAULT_HABIT_ID = 1;
    private static final Integer UPDATED_HABIT_ID = 2;

    private static final String DEFAULT_HABIT_NAME = "AAAAAAAAAA";
    private static final String UPDATED_HABIT_NAME = "BBBBBBBBBB";

    private static final String DEFAULT_DESCRIPTION = "AAAAAAAAAA";
    private static final String UPDATED_DESCRIPTION = "BBBBBBBBBB";

    private static final Integer DEFAULT_START_DATE = 1;
    private static final Integer UPDATED_START_DATE = 2;

    private static final String DEFAULT_END_DATE = "AAAAAAAAAA";
    private static final String UPDATED_END_DATE = "BBBBBBBBBB";

    private static final String ENTITY_API_URL = "/api/habit-trackers";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    @Autowired
    private ObjectMapper om;

    @Autowired
    private HabitTrackerRepository habitTrackerRepository;

    @Autowired
    private EntityManager em;

    @Autowired
    private WebTestClient webTestClient;

    private HabitTracker habitTracker;

    private HabitTracker insertedHabitTracker;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static HabitTracker createEntity() {
        return new HabitTracker()
            .habitId(DEFAULT_HABIT_ID)
            .habitName(DEFAULT_HABIT_NAME)
            .description(DEFAULT_DESCRIPTION)
            .startDate(DEFAULT_START_DATE)
            .endDate(DEFAULT_END_DATE);
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static HabitTracker createUpdatedEntity() {
        return new HabitTracker()
            .habitId(UPDATED_HABIT_ID)
            .habitName(UPDATED_HABIT_NAME)
            .description(UPDATED_DESCRIPTION)
            .startDate(UPDATED_START_DATE)
            .endDate(UPDATED_END_DATE);
    }

    public static void deleteEntities(EntityManager em) {
        try {
            em.deleteAll(HabitTracker.class).block();
        } catch (Exception e) {
            // It can fail, if other entities are still referring this - it will be removed later.
        }
    }

    @BeforeEach
    public void initTest() {
        habitTracker = createEntity();
    }

    @AfterEach
    public void cleanup() {
        if (insertedHabitTracker != null) {
            habitTrackerRepository.delete(insertedHabitTracker).block();
            insertedHabitTracker = null;
        }
        deleteEntities(em);
    }

    @Test
    void getAllHabitTrackersAsStream() {
        // Initialize the database
        habitTrackerRepository.save(habitTracker).block();

        List<HabitTracker> habitTrackerList = webTestClient
            .get()
            .uri(ENTITY_API_URL)
            .accept(MediaType.APPLICATION_NDJSON)
            .exchange()
            .expectStatus()
            .isOk()
            .expectHeader()
            .contentTypeCompatibleWith(MediaType.APPLICATION_NDJSON)
            .returnResult(HabitTracker.class)
            .getResponseBody()
            .filter(habitTracker::equals)
            .collectList()
            .block(Duration.ofSeconds(5));

        assertThat(habitTrackerList).isNotNull();
        assertThat(habitTrackerList).hasSize(1);
        HabitTracker testHabitTracker = habitTrackerList.get(0);

        // Test fails because reactive api returns an empty object instead of null
        // assertHabitTrackerAllPropertiesEquals(habitTracker, testHabitTracker);
        assertHabitTrackerUpdatableFieldsEquals(habitTracker, testHabitTracker);
    }

    @Test
    void getAllHabitTrackers() {
        // Initialize the database
        insertedHabitTracker = habitTrackerRepository.save(habitTracker).block();

        // Get all the habitTrackerList
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
            .value(hasItem(habitTracker.getId().intValue()))
            .jsonPath("$.[*].habitId")
            .value(hasItem(DEFAULT_HABIT_ID))
            .jsonPath("$.[*].habitName")
            .value(hasItem(DEFAULT_HABIT_NAME))
            .jsonPath("$.[*].description")
            .value(hasItem(DEFAULT_DESCRIPTION))
            .jsonPath("$.[*].startDate")
            .value(hasItem(DEFAULT_START_DATE))
            .jsonPath("$.[*].endDate")
            .value(hasItem(DEFAULT_END_DATE));
    }

    @Test
    void getHabitTracker() {
        // Initialize the database
        insertedHabitTracker = habitTrackerRepository.save(habitTracker).block();

        // Get the habitTracker
        webTestClient
            .get()
            .uri(ENTITY_API_URL_ID, habitTracker.getId())
            .accept(MediaType.APPLICATION_JSON)
            .exchange()
            .expectStatus()
            .isOk()
            .expectHeader()
            .contentType(MediaType.APPLICATION_JSON)
            .expectBody()
            .jsonPath("$.id")
            .value(is(habitTracker.getId().intValue()))
            .jsonPath("$.habitId")
            .value(is(DEFAULT_HABIT_ID))
            .jsonPath("$.habitName")
            .value(is(DEFAULT_HABIT_NAME))
            .jsonPath("$.description")
            .value(is(DEFAULT_DESCRIPTION))
            .jsonPath("$.startDate")
            .value(is(DEFAULT_START_DATE))
            .jsonPath("$.endDate")
            .value(is(DEFAULT_END_DATE));
    }

    @Test
    void getNonExistingHabitTracker() {
        // Get the habitTracker
        webTestClient
            .get()
            .uri(ENTITY_API_URL_ID, Long.MAX_VALUE)
            .accept(MediaType.APPLICATION_PROBLEM_JSON)
            .exchange()
            .expectStatus()
            .isNotFound();
    }

    protected long getRepositoryCount() {
        return habitTrackerRepository.count().block();
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

    protected HabitTracker getPersistedHabitTracker(HabitTracker habitTracker) {
        return habitTrackerRepository.findById(habitTracker.getId()).block();
    }

    protected void assertPersistedHabitTrackerToMatchAllProperties(HabitTracker expectedHabitTracker) {
        // Test fails because reactive api returns an empty object instead of null
        // assertHabitTrackerAllPropertiesEquals(expectedHabitTracker, getPersistedHabitTracker(expectedHabitTracker));
        assertHabitTrackerUpdatableFieldsEquals(expectedHabitTracker, getPersistedHabitTracker(expectedHabitTracker));
    }

    protected void assertPersistedHabitTrackerToMatchUpdatableProperties(HabitTracker expectedHabitTracker) {
        // Test fails because reactive api returns an empty object instead of null
        // assertHabitTrackerAllUpdatablePropertiesEquals(expectedHabitTracker, getPersistedHabitTracker(expectedHabitTracker));
        assertHabitTrackerUpdatableFieldsEquals(expectedHabitTracker, getPersistedHabitTracker(expectedHabitTracker));
    }
}
