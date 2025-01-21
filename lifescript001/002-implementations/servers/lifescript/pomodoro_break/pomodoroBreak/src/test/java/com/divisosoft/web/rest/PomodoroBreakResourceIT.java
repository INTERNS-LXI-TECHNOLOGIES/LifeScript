package com.divisosoft.web.rest;

import static com.divisosoft.domain.PomodoroBreakAsserts.*;
import static com.divisosoft.web.rest.TestUtil.createUpdateProxyForBean;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.is;

import com.divisosoft.IntegrationTest;
import com.divisosoft.domain.PomodoroBreak;
import com.divisosoft.repository.EntityManager;
import com.divisosoft.repository.PomodoroBreakRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.time.Duration;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
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
 * Integration tests for the {@link PomodoroBreakResource} REST controller.
 */
@IntegrationTest
@AutoConfigureWebTestClient(timeout = IntegrationTest.DEFAULT_ENTITY_TIMEOUT)
@WithMockUser
class PomodoroBreakResourceIT {

    private static final String DEFAULT_USER_NAME = "AAAAAAAAAA";
    private static final String UPDATED_USER_NAME = "BBBBBBBBBB";

    private static final Integer DEFAULT_TOTAL_WORKING_HOUR = 1;
    private static final Integer UPDATED_TOTAL_WORKING_HOUR = 2;

    private static final Integer DEFAULT_DAILY_DURATION_OF_WORK = 1;
    private static final Integer UPDATED_DAILY_DURATION_OF_WORK = 2;

    private static final Integer DEFAULT_SPLIT_BREAK_DURATION = 1;
    private static final Integer UPDATED_SPLIT_BREAK_DURATION = 2;

    private static final Integer DEFAULT_BREAK_DURATION = 1;
    private static final Integer UPDATED_BREAK_DURATION = 2;

    private static final Integer DEFAULT_COMPLETED_BREAKS = 1;
    private static final Integer UPDATED_COMPLETED_BREAKS = 2;

    private static final Instant DEFAULT_DATE_OF_POMODORO = Instant.ofEpochMilli(0L);
    private static final Instant UPDATED_DATE_OF_POMODORO = Instant.now().truncatedTo(ChronoUnit.MILLIS);

    private static final Instant DEFAULT_TIME_OF_POMODORO_CREATION = Instant.ofEpochMilli(0L);
    private static final Instant UPDATED_TIME_OF_POMODORO_CREATION = Instant.now().truncatedTo(ChronoUnit.MILLIS);

    private static final Boolean DEFAULT_NOTIFICATION_FOR_BREAK = false;
    private static final Boolean UPDATED_NOTIFICATION_FOR_BREAK = true;

    private static final String DEFAULT_FINAL_MESSAGE = "AAAAAAAAAA";
    private static final String UPDATED_FINAL_MESSAGE = "BBBBBBBBBB";

    private static final String ENTITY_API_URL = "/api/pomodoro-breaks";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private ObjectMapper om;

    @Autowired
    private PomodoroBreakRepository pomodoroBreakRepository;

    @Autowired
    private EntityManager em;

    @Autowired
    private WebTestClient webTestClient;

    private PomodoroBreak pomodoroBreak;

    private PomodoroBreak insertedPomodoroBreak;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static PomodoroBreak createEntity() {
        return new PomodoroBreak()
            .userName(DEFAULT_USER_NAME)
            .totalWorkingHour(DEFAULT_TOTAL_WORKING_HOUR)
            .dailyDurationOfWork(DEFAULT_DAILY_DURATION_OF_WORK)
            .splitBreakDuration(DEFAULT_SPLIT_BREAK_DURATION)
            .breakDuration(DEFAULT_BREAK_DURATION)
            .completedBreaks(DEFAULT_COMPLETED_BREAKS)
            .dateOfPomodoro(DEFAULT_DATE_OF_POMODORO)
            .timeOfPomodoroCreation(DEFAULT_TIME_OF_POMODORO_CREATION)
            .notificationForBreak(DEFAULT_NOTIFICATION_FOR_BREAK)
            .finalMessage(DEFAULT_FINAL_MESSAGE);
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static PomodoroBreak createUpdatedEntity() {
        return new PomodoroBreak()
            .userName(UPDATED_USER_NAME)
            .totalWorkingHour(UPDATED_TOTAL_WORKING_HOUR)
            .dailyDurationOfWork(UPDATED_DAILY_DURATION_OF_WORK)
            .splitBreakDuration(UPDATED_SPLIT_BREAK_DURATION)
            .breakDuration(UPDATED_BREAK_DURATION)
            .completedBreaks(UPDATED_COMPLETED_BREAKS)
            .dateOfPomodoro(UPDATED_DATE_OF_POMODORO)
            .timeOfPomodoroCreation(UPDATED_TIME_OF_POMODORO_CREATION)
            .notificationForBreak(UPDATED_NOTIFICATION_FOR_BREAK)
            .finalMessage(UPDATED_FINAL_MESSAGE);
    }

    public static void deleteEntities(EntityManager em) {
        try {
            em.deleteAll(PomodoroBreak.class).block();
        } catch (Exception e) {
            // It can fail, if other entities are still referring this - it will be removed later.
        }
    }

    @BeforeEach
    public void initTest() {
        pomodoroBreak = createEntity();
    }

    @AfterEach
    public void cleanup() {
        if (insertedPomodoroBreak != null) {
            pomodoroBreakRepository.delete(insertedPomodoroBreak).block();
            insertedPomodoroBreak = null;
        }
        deleteEntities(em);
    }

    @Test
    void createPomodoroBreak() throws Exception {
        long databaseSizeBeforeCreate = getRepositoryCount();
        // Create the PomodoroBreak
        var returnedPomodoroBreak = webTestClient
            .post()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(pomodoroBreak))
            .exchange()
            .expectStatus()
            .isCreated()
            .expectBody(PomodoroBreak.class)
            .returnResult()
            .getResponseBody();

        // Validate the PomodoroBreak in the database
        assertIncrementedRepositoryCount(databaseSizeBeforeCreate);
        assertPomodoroBreakUpdatableFieldsEquals(returnedPomodoroBreak, getPersistedPomodoroBreak(returnedPomodoroBreak));

        insertedPomodoroBreak = returnedPomodoroBreak;
    }

    @Test
    void createPomodoroBreakWithExistingId() throws Exception {
        // Create the PomodoroBreak with an existing ID
        pomodoroBreak.setId(1L);

        long databaseSizeBeforeCreate = getRepositoryCount();

        // An entity with an existing ID cannot be created, so this API call must fail
        webTestClient
            .post()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(pomodoroBreak))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the PomodoroBreak in the database
        assertSameRepositoryCount(databaseSizeBeforeCreate);
    }

    @Test
    void getAllPomodoroBreaksAsStream() {
        // Initialize the database
        pomodoroBreakRepository.save(pomodoroBreak).block();

        List<PomodoroBreak> pomodoroBreakList = webTestClient
            .get()
            .uri(ENTITY_API_URL)
            .accept(MediaType.APPLICATION_NDJSON)
            .exchange()
            .expectStatus()
            .isOk()
            .expectHeader()
            .contentTypeCompatibleWith(MediaType.APPLICATION_NDJSON)
            .returnResult(PomodoroBreak.class)
            .getResponseBody()
            .filter(pomodoroBreak::equals)
            .collectList()
            .block(Duration.ofSeconds(5));

        assertThat(pomodoroBreakList).isNotNull();
        assertThat(pomodoroBreakList).hasSize(1);
        PomodoroBreak testPomodoroBreak = pomodoroBreakList.get(0);

        // Test fails because reactive api returns an empty object instead of null
        // assertPomodoroBreakAllPropertiesEquals(pomodoroBreak, testPomodoroBreak);
        assertPomodoroBreakUpdatableFieldsEquals(pomodoroBreak, testPomodoroBreak);
    }

    @Test
    void getAllPomodoroBreaks() {
        // Initialize the database
        insertedPomodoroBreak = pomodoroBreakRepository.save(pomodoroBreak).block();

        // Get all the pomodoroBreakList
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
            .value(hasItem(pomodoroBreak.getId().intValue()))
            .jsonPath("$.[*].userName")
            .value(hasItem(DEFAULT_USER_NAME))
            .jsonPath("$.[*].totalWorkingHour")
            .value(hasItem(DEFAULT_TOTAL_WORKING_HOUR))
            .jsonPath("$.[*].dailyDurationOfWork")
            .value(hasItem(DEFAULT_DAILY_DURATION_OF_WORK))
            .jsonPath("$.[*].splitBreakDuration")
            .value(hasItem(DEFAULT_SPLIT_BREAK_DURATION))
            .jsonPath("$.[*].breakDuration")
            .value(hasItem(DEFAULT_BREAK_DURATION))
            .jsonPath("$.[*].completedBreaks")
            .value(hasItem(DEFAULT_COMPLETED_BREAKS))
            .jsonPath("$.[*].dateOfPomodoro")
            .value(hasItem(DEFAULT_DATE_OF_POMODORO.toString()))
            .jsonPath("$.[*].timeOfPomodoroCreation")
            .value(hasItem(DEFAULT_TIME_OF_POMODORO_CREATION.toString()))
            .jsonPath("$.[*].notificationForBreak")
            .value(hasItem(DEFAULT_NOTIFICATION_FOR_BREAK))
            .jsonPath("$.[*].finalMessage")
            .value(hasItem(DEFAULT_FINAL_MESSAGE));
    }

    @Test
    void getPomodoroBreak() {
        // Initialize the database
        insertedPomodoroBreak = pomodoroBreakRepository.save(pomodoroBreak).block();

        // Get the pomodoroBreak
        webTestClient
            .get()
            .uri(ENTITY_API_URL_ID, pomodoroBreak.getId())
            .accept(MediaType.APPLICATION_JSON)
            .exchange()
            .expectStatus()
            .isOk()
            .expectHeader()
            .contentType(MediaType.APPLICATION_JSON)
            .expectBody()
            .jsonPath("$.id")
            .value(is(pomodoroBreak.getId().intValue()))
            .jsonPath("$.userName")
            .value(is(DEFAULT_USER_NAME))
            .jsonPath("$.totalWorkingHour")
            .value(is(DEFAULT_TOTAL_WORKING_HOUR))
            .jsonPath("$.dailyDurationOfWork")
            .value(is(DEFAULT_DAILY_DURATION_OF_WORK))
            .jsonPath("$.splitBreakDuration")
            .value(is(DEFAULT_SPLIT_BREAK_DURATION))
            .jsonPath("$.breakDuration")
            .value(is(DEFAULT_BREAK_DURATION))
            .jsonPath("$.completedBreaks")
            .value(is(DEFAULT_COMPLETED_BREAKS))
            .jsonPath("$.dateOfPomodoro")
            .value(is(DEFAULT_DATE_OF_POMODORO.toString()))
            .jsonPath("$.timeOfPomodoroCreation")
            .value(is(DEFAULT_TIME_OF_POMODORO_CREATION.toString()))
            .jsonPath("$.notificationForBreak")
            .value(is(DEFAULT_NOTIFICATION_FOR_BREAK))
            .jsonPath("$.finalMessage")
            .value(is(DEFAULT_FINAL_MESSAGE));
    }

    @Test
    void getNonExistingPomodoroBreak() {
        // Get the pomodoroBreak
        webTestClient
            .get()
            .uri(ENTITY_API_URL_ID, Long.MAX_VALUE)
            .accept(MediaType.APPLICATION_PROBLEM_JSON)
            .exchange()
            .expectStatus()
            .isNotFound();
    }

    @Test
    void putExistingPomodoroBreak() throws Exception {
        // Initialize the database
        insertedPomodoroBreak = pomodoroBreakRepository.save(pomodoroBreak).block();

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the pomodoroBreak
        PomodoroBreak updatedPomodoroBreak = pomodoroBreakRepository.findById(pomodoroBreak.getId()).block();
        updatedPomodoroBreak
            .userName(UPDATED_USER_NAME)
            .totalWorkingHour(UPDATED_TOTAL_WORKING_HOUR)
            .dailyDurationOfWork(UPDATED_DAILY_DURATION_OF_WORK)
            .splitBreakDuration(UPDATED_SPLIT_BREAK_DURATION)
            .breakDuration(UPDATED_BREAK_DURATION)
            .completedBreaks(UPDATED_COMPLETED_BREAKS)
            .dateOfPomodoro(UPDATED_DATE_OF_POMODORO)
            .timeOfPomodoroCreation(UPDATED_TIME_OF_POMODORO_CREATION)
            .notificationForBreak(UPDATED_NOTIFICATION_FOR_BREAK)
            .finalMessage(UPDATED_FINAL_MESSAGE);

        webTestClient
            .put()
            .uri(ENTITY_API_URL_ID, updatedPomodoroBreak.getId())
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(updatedPomodoroBreak))
            .exchange()
            .expectStatus()
            .isOk();

        // Validate the PomodoroBreak in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPersistedPomodoroBreakToMatchAllProperties(updatedPomodoroBreak);
    }

    @Test
    void putNonExistingPomodoroBreak() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        pomodoroBreak.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        webTestClient
            .put()
            .uri(ENTITY_API_URL_ID, pomodoroBreak.getId())
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(pomodoroBreak))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the PomodoroBreak in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void putWithIdMismatchPomodoroBreak() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        pomodoroBreak.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .put()
            .uri(ENTITY_API_URL_ID, longCount.incrementAndGet())
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(pomodoroBreak))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the PomodoroBreak in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void putWithMissingIdPathParamPomodoroBreak() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        pomodoroBreak.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .put()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(pomodoroBreak))
            .exchange()
            .expectStatus()
            .isEqualTo(405);

        // Validate the PomodoroBreak in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void partialUpdatePomodoroBreakWithPatch() throws Exception {
        // Initialize the database
        insertedPomodoroBreak = pomodoroBreakRepository.save(pomodoroBreak).block();

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the pomodoroBreak using partial update
        PomodoroBreak partialUpdatedPomodoroBreak = new PomodoroBreak();
        partialUpdatedPomodoroBreak.setId(pomodoroBreak.getId());

        partialUpdatedPomodoroBreak
            .breakDuration(UPDATED_BREAK_DURATION)
            .timeOfPomodoroCreation(UPDATED_TIME_OF_POMODORO_CREATION)
            .notificationForBreak(UPDATED_NOTIFICATION_FOR_BREAK)
            .finalMessage(UPDATED_FINAL_MESSAGE);

        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, partialUpdatedPomodoroBreak.getId())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(partialUpdatedPomodoroBreak))
            .exchange()
            .expectStatus()
            .isOk();

        // Validate the PomodoroBreak in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPomodoroBreakUpdatableFieldsEquals(
            createUpdateProxyForBean(partialUpdatedPomodoroBreak, pomodoroBreak),
            getPersistedPomodoroBreak(pomodoroBreak)
        );
    }

    @Test
    void fullUpdatePomodoroBreakWithPatch() throws Exception {
        // Initialize the database
        insertedPomodoroBreak = pomodoroBreakRepository.save(pomodoroBreak).block();

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the pomodoroBreak using partial update
        PomodoroBreak partialUpdatedPomodoroBreak = new PomodoroBreak();
        partialUpdatedPomodoroBreak.setId(pomodoroBreak.getId());

        partialUpdatedPomodoroBreak
            .userName(UPDATED_USER_NAME)
            .totalWorkingHour(UPDATED_TOTAL_WORKING_HOUR)
            .dailyDurationOfWork(UPDATED_DAILY_DURATION_OF_WORK)
            .splitBreakDuration(UPDATED_SPLIT_BREAK_DURATION)
            .breakDuration(UPDATED_BREAK_DURATION)
            .completedBreaks(UPDATED_COMPLETED_BREAKS)
            .dateOfPomodoro(UPDATED_DATE_OF_POMODORO)
            .timeOfPomodoroCreation(UPDATED_TIME_OF_POMODORO_CREATION)
            .notificationForBreak(UPDATED_NOTIFICATION_FOR_BREAK)
            .finalMessage(UPDATED_FINAL_MESSAGE);

        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, partialUpdatedPomodoroBreak.getId())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(partialUpdatedPomodoroBreak))
            .exchange()
            .expectStatus()
            .isOk();

        // Validate the PomodoroBreak in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPomodoroBreakUpdatableFieldsEquals(partialUpdatedPomodoroBreak, getPersistedPomodoroBreak(partialUpdatedPomodoroBreak));
    }

    @Test
    void patchNonExistingPomodoroBreak() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        pomodoroBreak.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, pomodoroBreak.getId())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(pomodoroBreak))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the PomodoroBreak in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void patchWithIdMismatchPomodoroBreak() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        pomodoroBreak.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, longCount.incrementAndGet())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(pomodoroBreak))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the PomodoroBreak in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void patchWithMissingIdPathParamPomodoroBreak() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        pomodoroBreak.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .patch()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(pomodoroBreak))
            .exchange()
            .expectStatus()
            .isEqualTo(405);

        // Validate the PomodoroBreak in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void deletePomodoroBreak() {
        // Initialize the database
        insertedPomodoroBreak = pomodoroBreakRepository.save(pomodoroBreak).block();

        long databaseSizeBeforeDelete = getRepositoryCount();

        // Delete the pomodoroBreak
        webTestClient
            .delete()
            .uri(ENTITY_API_URL_ID, pomodoroBreak.getId())
            .accept(MediaType.APPLICATION_JSON)
            .exchange()
            .expectStatus()
            .isNoContent();

        // Validate the database contains one less item
        assertDecrementedRepositoryCount(databaseSizeBeforeDelete);
    }

    protected long getRepositoryCount() {
        return pomodoroBreakRepository.count().block();
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

    protected PomodoroBreak getPersistedPomodoroBreak(PomodoroBreak pomodoroBreak) {
        return pomodoroBreakRepository.findById(pomodoroBreak.getId()).block();
    }

    protected void assertPersistedPomodoroBreakToMatchAllProperties(PomodoroBreak expectedPomodoroBreak) {
        // Test fails because reactive api returns an empty object instead of null
        // assertPomodoroBreakAllPropertiesEquals(expectedPomodoroBreak, getPersistedPomodoroBreak(expectedPomodoroBreak));
        assertPomodoroBreakUpdatableFieldsEquals(expectedPomodoroBreak, getPersistedPomodoroBreak(expectedPomodoroBreak));
    }

    protected void assertPersistedPomodoroBreakToMatchUpdatableProperties(PomodoroBreak expectedPomodoroBreak) {
        // Test fails because reactive api returns an empty object instead of null
        // assertPomodoroBreakAllUpdatablePropertiesEquals(expectedPomodoroBreak, getPersistedPomodoroBreak(expectedPomodoroBreak));
        assertPomodoroBreakUpdatableFieldsEquals(expectedPomodoroBreak, getPersistedPomodoroBreak(expectedPomodoroBreak));
    }
}
