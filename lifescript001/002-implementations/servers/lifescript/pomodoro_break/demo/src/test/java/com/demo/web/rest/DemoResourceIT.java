package com.demo.web.rest;

import static com.demo.domain.DemoAsserts.*;
import static com.demo.web.rest.TestUtil.createUpdateProxyForBean;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.is;

import com.demo.IntegrationTest;
import com.demo.domain.Demo;
import com.demo.repository.DemoRepository;
import com.demo.repository.EntityManager;
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
 * Integration tests for the {@link DemoResource} REST controller.
 */
@IntegrationTest
@AutoConfigureWebTestClient(timeout = IntegrationTest.DEFAULT_ENTITY_TIMEOUT)
@WithMockUser
class DemoResourceIT {

    private static final String DEFAULT_USERNAME = "AAAAAAAAAA";
    private static final String UPDATED_USERNAME = "BBBBBBBBBB";

    private static final Integer DEFAULT_MOBILE_NUMBER = 1;
    private static final Integer UPDATED_MOBILE_NUMBER = 2;

    private static final String ENTITY_API_URL = "/api/demos";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private ObjectMapper om;

    @Autowired
    private DemoRepository demoRepository;

    @Autowired
    private EntityManager em;

    @Autowired
    private WebTestClient webTestClient;

    private Demo demo;

    private Demo insertedDemo;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static Demo createEntity() {
        return new Demo().username(DEFAULT_USERNAME).mobileNumber(DEFAULT_MOBILE_NUMBER);
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static Demo createUpdatedEntity() {
        return new Demo().username(UPDATED_USERNAME).mobileNumber(UPDATED_MOBILE_NUMBER);
    }

    public static void deleteEntities(EntityManager em) {
        try {
            em.deleteAll(Demo.class).block();
        } catch (Exception e) {
            // It can fail, if other entities are still referring this - it will be removed later.
        }
    }

    @BeforeEach
    public void initTest() {
        demo = createEntity();
    }

    @AfterEach
    public void cleanup() {
        if (insertedDemo != null) {
            demoRepository.delete(insertedDemo).block();
            insertedDemo = null;
        }
        deleteEntities(em);
    }

    @Test
    void createDemo() throws Exception {
        long databaseSizeBeforeCreate = getRepositoryCount();
        // Create the Demo
        var returnedDemo = webTestClient
            .post()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(demo))
            .exchange()
            .expectStatus()
            .isCreated()
            .expectBody(Demo.class)
            .returnResult()
            .getResponseBody();

        // Validate the Demo in the database
        assertIncrementedRepositoryCount(databaseSizeBeforeCreate);
        assertDemoUpdatableFieldsEquals(returnedDemo, getPersistedDemo(returnedDemo));

        insertedDemo = returnedDemo;
    }

    @Test
    void createDemoWithExistingId() throws Exception {
        // Create the Demo with an existing ID
        demo.setId(1L);

        long databaseSizeBeforeCreate = getRepositoryCount();

        // An entity with an existing ID cannot be created, so this API call must fail
        webTestClient
            .post()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(demo))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the Demo in the database
        assertSameRepositoryCount(databaseSizeBeforeCreate);
    }

    @Test
    void getAllDemosAsStream() {
        // Initialize the database
        demoRepository.save(demo).block();

        List<Demo> demoList = webTestClient
            .get()
            .uri(ENTITY_API_URL)
            .accept(MediaType.APPLICATION_NDJSON)
            .exchange()
            .expectStatus()
            .isOk()
            .expectHeader()
            .contentTypeCompatibleWith(MediaType.APPLICATION_NDJSON)
            .returnResult(Demo.class)
            .getResponseBody()
            .filter(demo::equals)
            .collectList()
            .block(Duration.ofSeconds(5));

        assertThat(demoList).isNotNull();
        assertThat(demoList).hasSize(1);
        Demo testDemo = demoList.get(0);

        // Test fails because reactive api returns an empty object instead of null
        // assertDemoAllPropertiesEquals(demo, testDemo);
        assertDemoUpdatableFieldsEquals(demo, testDemo);
    }

    @Test
    void getAllDemos() {
        // Initialize the database
        insertedDemo = demoRepository.save(demo).block();

        // Get all the demoList
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
            .value(hasItem(demo.getId().intValue()))
            .jsonPath("$.[*].username")
            .value(hasItem(DEFAULT_USERNAME))
            .jsonPath("$.[*].mobileNumber")
            .value(hasItem(DEFAULT_MOBILE_NUMBER));
    }

    @Test
    void getDemo() {
        // Initialize the database
        insertedDemo = demoRepository.save(demo).block();

        // Get the demo
        webTestClient
            .get()
            .uri(ENTITY_API_URL_ID, demo.getId())
            .accept(MediaType.APPLICATION_JSON)
            .exchange()
            .expectStatus()
            .isOk()
            .expectHeader()
            .contentType(MediaType.APPLICATION_JSON)
            .expectBody()
            .jsonPath("$.id")
            .value(is(demo.getId().intValue()))
            .jsonPath("$.username")
            .value(is(DEFAULT_USERNAME))
            .jsonPath("$.mobileNumber")
            .value(is(DEFAULT_MOBILE_NUMBER));
    }

    @Test
    void getNonExistingDemo() {
        // Get the demo
        webTestClient
            .get()
            .uri(ENTITY_API_URL_ID, Long.MAX_VALUE)
            .accept(MediaType.APPLICATION_PROBLEM_JSON)
            .exchange()
            .expectStatus()
            .isNotFound();
    }

    @Test
    void putExistingDemo() throws Exception {
        // Initialize the database
        insertedDemo = demoRepository.save(demo).block();

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the demo
        Demo updatedDemo = demoRepository.findById(demo.getId()).block();
        updatedDemo.username(UPDATED_USERNAME).mobileNumber(UPDATED_MOBILE_NUMBER);

        webTestClient
            .put()
            .uri(ENTITY_API_URL_ID, updatedDemo.getId())
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(updatedDemo))
            .exchange()
            .expectStatus()
            .isOk();

        // Validate the Demo in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPersistedDemoToMatchAllProperties(updatedDemo);
    }

    @Test
    void putNonExistingDemo() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        demo.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        webTestClient
            .put()
            .uri(ENTITY_API_URL_ID, demo.getId())
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(demo))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the Demo in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void putWithIdMismatchDemo() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        demo.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .put()
            .uri(ENTITY_API_URL_ID, longCount.incrementAndGet())
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(demo))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the Demo in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void putWithMissingIdPathParamDemo() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        demo.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .put()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(demo))
            .exchange()
            .expectStatus()
            .isEqualTo(405);

        // Validate the Demo in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void partialUpdateDemoWithPatch() throws Exception {
        // Initialize the database
        insertedDemo = demoRepository.save(demo).block();

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the demo using partial update
        Demo partialUpdatedDemo = new Demo();
        partialUpdatedDemo.setId(demo.getId());

        partialUpdatedDemo.username(UPDATED_USERNAME);

        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, partialUpdatedDemo.getId())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(partialUpdatedDemo))
            .exchange()
            .expectStatus()
            .isOk();

        // Validate the Demo in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertDemoUpdatableFieldsEquals(createUpdateProxyForBean(partialUpdatedDemo, demo), getPersistedDemo(demo));
    }

    @Test
    void fullUpdateDemoWithPatch() throws Exception {
        // Initialize the database
        insertedDemo = demoRepository.save(demo).block();

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the demo using partial update
        Demo partialUpdatedDemo = new Demo();
        partialUpdatedDemo.setId(demo.getId());

        partialUpdatedDemo.username(UPDATED_USERNAME).mobileNumber(UPDATED_MOBILE_NUMBER);

        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, partialUpdatedDemo.getId())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(partialUpdatedDemo))
            .exchange()
            .expectStatus()
            .isOk();

        // Validate the Demo in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertDemoUpdatableFieldsEquals(partialUpdatedDemo, getPersistedDemo(partialUpdatedDemo));
    }

    @Test
    void patchNonExistingDemo() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        demo.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, demo.getId())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(demo))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the Demo in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void patchWithIdMismatchDemo() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        demo.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, longCount.incrementAndGet())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(demo))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the Demo in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void patchWithMissingIdPathParamDemo() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        demo.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .patch()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(demo))
            .exchange()
            .expectStatus()
            .isEqualTo(405);

        // Validate the Demo in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void deleteDemo() {
        // Initialize the database
        insertedDemo = demoRepository.save(demo).block();

        long databaseSizeBeforeDelete = getRepositoryCount();

        // Delete the demo
        webTestClient
            .delete()
            .uri(ENTITY_API_URL_ID, demo.getId())
            .accept(MediaType.APPLICATION_JSON)
            .exchange()
            .expectStatus()
            .isNoContent();

        // Validate the database contains one less item
        assertDecrementedRepositoryCount(databaseSizeBeforeDelete);
    }

    protected long getRepositoryCount() {
        return demoRepository.count().block();
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

    protected Demo getPersistedDemo(Demo demo) {
        return demoRepository.findById(demo.getId()).block();
    }

    protected void assertPersistedDemoToMatchAllProperties(Demo expectedDemo) {
        // Test fails because reactive api returns an empty object instead of null
        // assertDemoAllPropertiesEquals(expectedDemo, getPersistedDemo(expectedDemo));
        assertDemoUpdatableFieldsEquals(expectedDemo, getPersistedDemo(expectedDemo));
    }

    protected void assertPersistedDemoToMatchUpdatableProperties(Demo expectedDemo) {
        // Test fails because reactive api returns an empty object instead of null
        // assertDemoAllUpdatablePropertiesEquals(expectedDemo, getPersistedDemo(expectedDemo));
        assertDemoUpdatableFieldsEquals(expectedDemo, getPersistedDemo(expectedDemo));
    }
}
