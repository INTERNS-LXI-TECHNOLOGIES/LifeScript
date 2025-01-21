package com.diviso.dailyjournal.web.rest;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.is;

import com.diviso.dailyjournal.IntegrationTest;
import com.diviso.dailyjournal.domain.DailyJournal;
import com.diviso.dailyjournal.repository.DailyJournalRepository;
import com.diviso.dailyjournal.repository.EntityManager;
import java.time.Duration;
import java.time.LocalDate;
import java.time.ZoneId;
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
 * Integration tests for the {@link DailyJournalResource} REST controller.
 */
@IntegrationTest
@AutoConfigureWebTestClient(timeout = IntegrationTest.DEFAULT_ENTITY_TIMEOUT)
@WithMockUser
class DailyJournalResourceIT {

    private static final String DEFAULT_TITLE = "AAAAAAAAAA";
    private static final String UPDATED_TITLE = "BBBBBBBBBB";

    private static final String DEFAULT_CONTENT = "AAAAAAAAAA";
    private static final String UPDATED_CONTENT = "BBBBBBBBBB";

    private static final LocalDate DEFAULT_DATE = LocalDate.ofEpochDay(0L);
    private static final LocalDate UPDATED_DATE = LocalDate.now(ZoneId.systemDefault());

    private static final String ENTITY_API_URL = "/api/daily-journals";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private DailyJournalRepository dailyJournalRepository;

    @Autowired
    private EntityManager em;

    @Autowired
    private WebTestClient webTestClient;

    private DailyJournal dailyJournal;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static DailyJournal createEntity(EntityManager em) {
        DailyJournal dailyJournal = new DailyJournal().title(DEFAULT_TITLE).content(DEFAULT_CONTENT).date(DEFAULT_DATE);
        return dailyJournal;
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static DailyJournal createUpdatedEntity(EntityManager em) {
        DailyJournal dailyJournal = new DailyJournal().title(UPDATED_TITLE).content(UPDATED_CONTENT).date(UPDATED_DATE);
        return dailyJournal;
    }

    public static void deleteEntities(EntityManager em) {
        try {
            em.deleteAll(DailyJournal.class).block();
        } catch (Exception e) {
            // It can fail, if other entities are still referring this - it will be removed later.
        }
    }

    @AfterEach
    public void cleanup() {
        deleteEntities(em);
    }

    @BeforeEach
    public void initTest() {
        deleteEntities(em);
        dailyJournal = createEntity(em);
    }

    @Test
    void createDailyJournal() throws Exception {
        int databaseSizeBeforeCreate = dailyJournalRepository.findAll().collectList().block().size();
        // Create the DailyJournal
        webTestClient
            .post()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(TestUtil.convertObjectToJsonBytes(dailyJournal))
            .exchange()
            .expectStatus()
            .isCreated();

        // Validate the DailyJournal in the database
        List<DailyJournal> dailyJournalList = dailyJournalRepository.findAll().collectList().block();
        assertThat(dailyJournalList).hasSize(databaseSizeBeforeCreate + 1);
        DailyJournal testDailyJournal = dailyJournalList.get(dailyJournalList.size() - 1);
        assertThat(testDailyJournal.getTitle()).isEqualTo(DEFAULT_TITLE);
        assertThat(testDailyJournal.getContent()).isEqualTo(DEFAULT_CONTENT);
        assertThat(testDailyJournal.getDate()).isEqualTo(DEFAULT_DATE);
    }

    @Test
    void createDailyJournalWithExistingId() throws Exception {
        // Create the DailyJournal with an existing ID
        dailyJournal.setId(1L);

        int databaseSizeBeforeCreate = dailyJournalRepository.findAll().collectList().block().size();

        // An entity with an existing ID cannot be created, so this API call must fail
        webTestClient
            .post()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(TestUtil.convertObjectToJsonBytes(dailyJournal))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the DailyJournal in the database
        List<DailyJournal> dailyJournalList = dailyJournalRepository.findAll().collectList().block();
        assertThat(dailyJournalList).hasSize(databaseSizeBeforeCreate);
    }

    @Test
    void checkTitleIsRequired() throws Exception {
        int databaseSizeBeforeTest = dailyJournalRepository.findAll().collectList().block().size();
        // set the field null
        dailyJournal.setTitle(null);

        // Create the DailyJournal, which fails.

        webTestClient
            .post()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(TestUtil.convertObjectToJsonBytes(dailyJournal))
            .exchange()
            .expectStatus()
            .isBadRequest();

        List<DailyJournal> dailyJournalList = dailyJournalRepository.findAll().collectList().block();
        assertThat(dailyJournalList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    void checkContentIsRequired() throws Exception {
        int databaseSizeBeforeTest = dailyJournalRepository.findAll().collectList().block().size();
        // set the field null
        dailyJournal.setContent(null);

        // Create the DailyJournal, which fails.

        webTestClient
            .post()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(TestUtil.convertObjectToJsonBytes(dailyJournal))
            .exchange()
            .expectStatus()
            .isBadRequest();

        List<DailyJournal> dailyJournalList = dailyJournalRepository.findAll().collectList().block();
        assertThat(dailyJournalList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    void checkDateIsRequired() throws Exception {
        int databaseSizeBeforeTest = dailyJournalRepository.findAll().collectList().block().size();
        // set the field null
        dailyJournal.setDate(null);

        // Create the DailyJournal, which fails.

        webTestClient
            .post()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(TestUtil.convertObjectToJsonBytes(dailyJournal))
            .exchange()
            .expectStatus()
            .isBadRequest();

        List<DailyJournal> dailyJournalList = dailyJournalRepository.findAll().collectList().block();
        assertThat(dailyJournalList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    void getAllDailyJournalsAsStream() {
        // Initialize the database
        dailyJournalRepository.save(dailyJournal).block();

        List<DailyJournal> dailyJournalList = webTestClient
            .get()
            .uri(ENTITY_API_URL)
            .accept(MediaType.APPLICATION_NDJSON)
            .exchange()
            .expectStatus()
            .isOk()
            .expectHeader()
            .contentTypeCompatibleWith(MediaType.APPLICATION_NDJSON)
            .returnResult(DailyJournal.class)
            .getResponseBody()
            .filter(dailyJournal::equals)
            .collectList()
            .block(Duration.ofSeconds(5));

        assertThat(dailyJournalList).isNotNull();
        assertThat(dailyJournalList).hasSize(1);
        DailyJournal testDailyJournal = dailyJournalList.get(0);
        assertThat(testDailyJournal.getTitle()).isEqualTo(DEFAULT_TITLE);
        assertThat(testDailyJournal.getContent()).isEqualTo(DEFAULT_CONTENT);
        assertThat(testDailyJournal.getDate()).isEqualTo(DEFAULT_DATE);
    }

    @Test
    void getAllDailyJournals() {
        // Initialize the database
        dailyJournalRepository.save(dailyJournal).block();

        // Get all the dailyJournalList
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
            .value(hasItem(dailyJournal.getId().intValue()))
            .jsonPath("$.[*].title")
            .value(hasItem(DEFAULT_TITLE))
            .jsonPath("$.[*].content")
            .value(hasItem(DEFAULT_CONTENT))
            .jsonPath("$.[*].date")
            .value(hasItem(DEFAULT_DATE.toString()));
    }

    @Test
    void getDailyJournal() {
        // Initialize the database
        dailyJournalRepository.save(dailyJournal).block();

        // Get the dailyJournal
        webTestClient
            .get()
            .uri(ENTITY_API_URL_ID, dailyJournal.getId())
            .accept(MediaType.APPLICATION_JSON)
            .exchange()
            .expectStatus()
            .isOk()
            .expectHeader()
            .contentType(MediaType.APPLICATION_JSON)
            .expectBody()
            .jsonPath("$.id")
            .value(is(dailyJournal.getId().intValue()))
            .jsonPath("$.title")
            .value(is(DEFAULT_TITLE))
            .jsonPath("$.content")
            .value(is(DEFAULT_CONTENT))
            .jsonPath("$.date")
            .value(is(DEFAULT_DATE.toString()));
    }

    @Test
    void getNonExistingDailyJournal() {
        // Get the dailyJournal
        webTestClient
            .get()
            .uri(ENTITY_API_URL_ID, Long.MAX_VALUE)
            .accept(MediaType.APPLICATION_PROBLEM_JSON)
            .exchange()
            .expectStatus()
            .isNotFound();
    }

    @Test
    void putExistingDailyJournal() throws Exception {
        // Initialize the database
        dailyJournalRepository.save(dailyJournal).block();

        int databaseSizeBeforeUpdate = dailyJournalRepository.findAll().collectList().block().size();

        // Update the dailyJournal
        DailyJournal updatedDailyJournal = dailyJournalRepository.findById(dailyJournal.getId()).block();
        updatedDailyJournal.title(UPDATED_TITLE).content(UPDATED_CONTENT).date(UPDATED_DATE);

        webTestClient
            .put()
            .uri(ENTITY_API_URL_ID, updatedDailyJournal.getId())
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(TestUtil.convertObjectToJsonBytes(updatedDailyJournal))
            .exchange()
            .expectStatus()
            .isOk();

        // Validate the DailyJournal in the database
        List<DailyJournal> dailyJournalList = dailyJournalRepository.findAll().collectList().block();
        assertThat(dailyJournalList).hasSize(databaseSizeBeforeUpdate);
        DailyJournal testDailyJournal = dailyJournalList.get(dailyJournalList.size() - 1);
        assertThat(testDailyJournal.getTitle()).isEqualTo(UPDATED_TITLE);
        assertThat(testDailyJournal.getContent()).isEqualTo(UPDATED_CONTENT);
        assertThat(testDailyJournal.getDate()).isEqualTo(UPDATED_DATE);
    }

    @Test
    void putNonExistingDailyJournal() throws Exception {
        int databaseSizeBeforeUpdate = dailyJournalRepository.findAll().collectList().block().size();
        dailyJournal.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        webTestClient
            .put()
            .uri(ENTITY_API_URL_ID, dailyJournal.getId())
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(TestUtil.convertObjectToJsonBytes(dailyJournal))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the DailyJournal in the database
        List<DailyJournal> dailyJournalList = dailyJournalRepository.findAll().collectList().block();
        assertThat(dailyJournalList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    void putWithIdMismatchDailyJournal() throws Exception {
        int databaseSizeBeforeUpdate = dailyJournalRepository.findAll().collectList().block().size();
        dailyJournal.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .put()
            .uri(ENTITY_API_URL_ID, longCount.incrementAndGet())
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(TestUtil.convertObjectToJsonBytes(dailyJournal))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the DailyJournal in the database
        List<DailyJournal> dailyJournalList = dailyJournalRepository.findAll().collectList().block();
        assertThat(dailyJournalList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    void putWithMissingIdPathParamDailyJournal() throws Exception {
        int databaseSizeBeforeUpdate = dailyJournalRepository.findAll().collectList().block().size();
        dailyJournal.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .put()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(TestUtil.convertObjectToJsonBytes(dailyJournal))
            .exchange()
            .expectStatus()
            .isEqualTo(405);

        // Validate the DailyJournal in the database
        List<DailyJournal> dailyJournalList = dailyJournalRepository.findAll().collectList().block();
        assertThat(dailyJournalList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    void partialUpdateDailyJournalWithPatch() throws Exception {
        // Initialize the database
        dailyJournalRepository.save(dailyJournal).block();

        int databaseSizeBeforeUpdate = dailyJournalRepository.findAll().collectList().block().size();

        // Update the dailyJournal using partial update
        DailyJournal partialUpdatedDailyJournal = new DailyJournal();
        partialUpdatedDailyJournal.setId(dailyJournal.getId());

        partialUpdatedDailyJournal.content(UPDATED_CONTENT).date(UPDATED_DATE);

        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, partialUpdatedDailyJournal.getId())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(TestUtil.convertObjectToJsonBytes(partialUpdatedDailyJournal))
            .exchange()
            .expectStatus()
            .isOk();

        // Validate the DailyJournal in the database
        List<DailyJournal> dailyJournalList = dailyJournalRepository.findAll().collectList().block();
        assertThat(dailyJournalList).hasSize(databaseSizeBeforeUpdate);
        DailyJournal testDailyJournal = dailyJournalList.get(dailyJournalList.size() - 1);
        assertThat(testDailyJournal.getTitle()).isEqualTo(DEFAULT_TITLE);
        assertThat(testDailyJournal.getContent()).isEqualTo(UPDATED_CONTENT);
        assertThat(testDailyJournal.getDate()).isEqualTo(UPDATED_DATE);
    }

    @Test
    void fullUpdateDailyJournalWithPatch() throws Exception {
        // Initialize the database
        dailyJournalRepository.save(dailyJournal).block();

        int databaseSizeBeforeUpdate = dailyJournalRepository.findAll().collectList().block().size();

        // Update the dailyJournal using partial update
        DailyJournal partialUpdatedDailyJournal = new DailyJournal();
        partialUpdatedDailyJournal.setId(dailyJournal.getId());

        partialUpdatedDailyJournal.title(UPDATED_TITLE).content(UPDATED_CONTENT).date(UPDATED_DATE);

        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, partialUpdatedDailyJournal.getId())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(TestUtil.convertObjectToJsonBytes(partialUpdatedDailyJournal))
            .exchange()
            .expectStatus()
            .isOk();

        // Validate the DailyJournal in the database
        List<DailyJournal> dailyJournalList = dailyJournalRepository.findAll().collectList().block();
        assertThat(dailyJournalList).hasSize(databaseSizeBeforeUpdate);
        DailyJournal testDailyJournal = dailyJournalList.get(dailyJournalList.size() - 1);
        assertThat(testDailyJournal.getTitle()).isEqualTo(UPDATED_TITLE);
        assertThat(testDailyJournal.getContent()).isEqualTo(UPDATED_CONTENT);
        assertThat(testDailyJournal.getDate()).isEqualTo(UPDATED_DATE);
    }

    @Test
    void patchNonExistingDailyJournal() throws Exception {
        int databaseSizeBeforeUpdate = dailyJournalRepository.findAll().collectList().block().size();
        dailyJournal.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, dailyJournal.getId())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(TestUtil.convertObjectToJsonBytes(dailyJournal))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the DailyJournal in the database
        List<DailyJournal> dailyJournalList = dailyJournalRepository.findAll().collectList().block();
        assertThat(dailyJournalList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    void patchWithIdMismatchDailyJournal() throws Exception {
        int databaseSizeBeforeUpdate = dailyJournalRepository.findAll().collectList().block().size();
        dailyJournal.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, longCount.incrementAndGet())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(TestUtil.convertObjectToJsonBytes(dailyJournal))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the DailyJournal in the database
        List<DailyJournal> dailyJournalList = dailyJournalRepository.findAll().collectList().block();
        assertThat(dailyJournalList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    void patchWithMissingIdPathParamDailyJournal() throws Exception {
        int databaseSizeBeforeUpdate = dailyJournalRepository.findAll().collectList().block().size();
        dailyJournal.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .patch()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(TestUtil.convertObjectToJsonBytes(dailyJournal))
            .exchange()
            .expectStatus()
            .isEqualTo(405);

        // Validate the DailyJournal in the database
        List<DailyJournal> dailyJournalList = dailyJournalRepository.findAll().collectList().block();
        assertThat(dailyJournalList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    void deleteDailyJournal() {
        // Initialize the database
        dailyJournalRepository.save(dailyJournal).block();

        int databaseSizeBeforeDelete = dailyJournalRepository.findAll().collectList().block().size();

        // Delete the dailyJournal
        webTestClient
            .delete()
            .uri(ENTITY_API_URL_ID, dailyJournal.getId())
            .accept(MediaType.APPLICATION_JSON)
            .exchange()
            .expectStatus()
            .isNoContent();

        // Validate the database contains one less item
        List<DailyJournal> dailyJournalList = dailyJournalRepository.findAll().collectList().block();
        assertThat(dailyJournalList).hasSize(databaseSizeBeforeDelete - 1);
    }
}
