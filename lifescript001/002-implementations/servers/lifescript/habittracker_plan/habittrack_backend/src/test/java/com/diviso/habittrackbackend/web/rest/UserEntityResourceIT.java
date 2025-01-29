package com.diviso.habittrackbackend.web.rest;

import static com.diviso.habittrackbackend.domain.UserEntityAsserts.*;
import static com.diviso.habittrackbackend.web.rest.TestUtil.createUpdateProxyForBean;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.is;

import com.diviso.habittrackbackend.IntegrationTest;
import com.diviso.habittrackbackend.domain.UserEntity;
import com.diviso.habittrackbackend.repository.EntityManager;
import com.diviso.habittrackbackend.repository.UserEntityRepository;
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
 * Integration tests for the {@link UserEntityResource} REST controller.
 */
@IntegrationTest
@AutoConfigureWebTestClient(timeout = IntegrationTest.DEFAULT_ENTITY_TIMEOUT)
@WithMockUser
class UserEntityResourceIT {

    private static final Integer DEFAULT_USER_ID = 1;
    private static final Integer UPDATED_USER_ID = 2;

    private static final String DEFAULT_USER_NAME = "AAAAAAAAAA";
    private static final String UPDATED_USER_NAME = "BBBBBBBBBB";

    private static final String ENTITY_API_URL = "/api/user-entities";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private ObjectMapper om;

    @Autowired
    private UserEntityRepository userEntityRepository;

    @Autowired
    private EntityManager em;

    @Autowired
    private WebTestClient webTestClient;

    private UserEntity userEntity;

    private UserEntity insertedUserEntity;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static UserEntity createEntity() {
        return new UserEntity().userId(DEFAULT_USER_ID).userName(DEFAULT_USER_NAME);
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static UserEntity createUpdatedEntity() {
        return new UserEntity().userId(UPDATED_USER_ID).userName(UPDATED_USER_NAME);
    }

    public static void deleteEntities(EntityManager em) {
        try {
            em.deleteAll(UserEntity.class).block();
        } catch (Exception e) {
            // It can fail, if other entities are still referring this - it will be removed later.
        }
    }

    @BeforeEach
    public void initTest() {
        userEntity = createEntity();
    }

    @AfterEach
    public void cleanup() {
        if (insertedUserEntity != null) {
            userEntityRepository.delete(insertedUserEntity).block();
            insertedUserEntity = null;
        }
        deleteEntities(em);
    }

    @Test
    void createUserEntity() throws Exception {
        long databaseSizeBeforeCreate = getRepositoryCount();
        // Create the UserEntity
        var returnedUserEntity = webTestClient
            .post()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(userEntity))
            .exchange()
            .expectStatus()
            .isCreated()
            .expectBody(UserEntity.class)
            .returnResult()
            .getResponseBody();

        // Validate the UserEntity in the database
        assertIncrementedRepositoryCount(databaseSizeBeforeCreate);
        assertUserEntityUpdatableFieldsEquals(returnedUserEntity, getPersistedUserEntity(returnedUserEntity));

        insertedUserEntity = returnedUserEntity;
    }

    @Test
    void createUserEntityWithExistingId() throws Exception {
        // Create the UserEntity with an existing ID
        userEntity.setId(1L);

        long databaseSizeBeforeCreate = getRepositoryCount();

        // An entity with an existing ID cannot be created, so this API call must fail
        webTestClient
            .post()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(userEntity))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the UserEntity in the database
        assertSameRepositoryCount(databaseSizeBeforeCreate);
    }

    @Test
    void getAllUserEntitiesAsStream() {
        // Initialize the database
        userEntityRepository.save(userEntity).block();

        List<UserEntity> userEntityList = webTestClient
            .get()
            .uri(ENTITY_API_URL)
            .accept(MediaType.APPLICATION_NDJSON)
            .exchange()
            .expectStatus()
            .isOk()
            .expectHeader()
            .contentTypeCompatibleWith(MediaType.APPLICATION_NDJSON)
            .returnResult(UserEntity.class)
            .getResponseBody()
            .filter(userEntity::equals)
            .collectList()
            .block(Duration.ofSeconds(5));

        assertThat(userEntityList).isNotNull();
        assertThat(userEntityList).hasSize(1);
        UserEntity testUserEntity = userEntityList.get(0);

        // Test fails because reactive api returns an empty object instead of null
        // assertUserEntityAllPropertiesEquals(userEntity, testUserEntity);
        assertUserEntityUpdatableFieldsEquals(userEntity, testUserEntity);
    }

    @Test
    void getAllUserEntities() {
        // Initialize the database
        insertedUserEntity = userEntityRepository.save(userEntity).block();

        // Get all the userEntityList
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
            .value(hasItem(userEntity.getId().intValue()))
            .jsonPath("$.[*].userId")
            .value(hasItem(DEFAULT_USER_ID))
            .jsonPath("$.[*].userName")
            .value(hasItem(DEFAULT_USER_NAME));
    }

    @Test
    void getUserEntity() {
        // Initialize the database
        insertedUserEntity = userEntityRepository.save(userEntity).block();

        // Get the userEntity
        webTestClient
            .get()
            .uri(ENTITY_API_URL_ID, userEntity.getId())
            .accept(MediaType.APPLICATION_JSON)
            .exchange()
            .expectStatus()
            .isOk()
            .expectHeader()
            .contentType(MediaType.APPLICATION_JSON)
            .expectBody()
            .jsonPath("$.id")
            .value(is(userEntity.getId().intValue()))
            .jsonPath("$.userId")
            .value(is(DEFAULT_USER_ID))
            .jsonPath("$.userName")
            .value(is(DEFAULT_USER_NAME));
    }

    @Test
    void getNonExistingUserEntity() {
        // Get the userEntity
        webTestClient
            .get()
            .uri(ENTITY_API_URL_ID, Long.MAX_VALUE)
            .accept(MediaType.APPLICATION_PROBLEM_JSON)
            .exchange()
            .expectStatus()
            .isNotFound();
    }

    @Test
    void putExistingUserEntity() throws Exception {
        // Initialize the database
        insertedUserEntity = userEntityRepository.save(userEntity).block();

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the userEntity
        UserEntity updatedUserEntity = userEntityRepository.findById(userEntity.getId()).block();
        updatedUserEntity.userId(UPDATED_USER_ID).userName(UPDATED_USER_NAME);

        webTestClient
            .put()
            .uri(ENTITY_API_URL_ID, updatedUserEntity.getId())
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(updatedUserEntity))
            .exchange()
            .expectStatus()
            .isOk();

        // Validate the UserEntity in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPersistedUserEntityToMatchAllProperties(updatedUserEntity);
    }

    @Test
    void putNonExistingUserEntity() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        userEntity.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        webTestClient
            .put()
            .uri(ENTITY_API_URL_ID, userEntity.getId())
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(userEntity))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the UserEntity in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void putWithIdMismatchUserEntity() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        userEntity.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .put()
            .uri(ENTITY_API_URL_ID, longCount.incrementAndGet())
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(userEntity))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the UserEntity in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void putWithMissingIdPathParamUserEntity() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        userEntity.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .put()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.APPLICATION_JSON)
            .bodyValue(om.writeValueAsBytes(userEntity))
            .exchange()
            .expectStatus()
            .isEqualTo(405);

        // Validate the UserEntity in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void partialUpdateUserEntityWithPatch() throws Exception {
        // Initialize the database
        insertedUserEntity = userEntityRepository.save(userEntity).block();

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the userEntity using partial update
        UserEntity partialUpdatedUserEntity = new UserEntity();
        partialUpdatedUserEntity.setId(userEntity.getId());

        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, partialUpdatedUserEntity.getId())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(partialUpdatedUserEntity))
            .exchange()
            .expectStatus()
            .isOk();

        // Validate the UserEntity in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertUserEntityUpdatableFieldsEquals(
            createUpdateProxyForBean(partialUpdatedUserEntity, userEntity),
            getPersistedUserEntity(userEntity)
        );
    }

    @Test
    void fullUpdateUserEntityWithPatch() throws Exception {
        // Initialize the database
        insertedUserEntity = userEntityRepository.save(userEntity).block();

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the userEntity using partial update
        UserEntity partialUpdatedUserEntity = new UserEntity();
        partialUpdatedUserEntity.setId(userEntity.getId());

        partialUpdatedUserEntity.userId(UPDATED_USER_ID).userName(UPDATED_USER_NAME);

        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, partialUpdatedUserEntity.getId())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(partialUpdatedUserEntity))
            .exchange()
            .expectStatus()
            .isOk();

        // Validate the UserEntity in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertUserEntityUpdatableFieldsEquals(partialUpdatedUserEntity, getPersistedUserEntity(partialUpdatedUserEntity));
    }

    @Test
    void patchNonExistingUserEntity() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        userEntity.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, userEntity.getId())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(userEntity))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the UserEntity in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void patchWithIdMismatchUserEntity() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        userEntity.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .patch()
            .uri(ENTITY_API_URL_ID, longCount.incrementAndGet())
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(userEntity))
            .exchange()
            .expectStatus()
            .isBadRequest();

        // Validate the UserEntity in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void patchWithMissingIdPathParamUserEntity() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        userEntity.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        webTestClient
            .patch()
            .uri(ENTITY_API_URL)
            .contentType(MediaType.valueOf("application/merge-patch+json"))
            .bodyValue(om.writeValueAsBytes(userEntity))
            .exchange()
            .expectStatus()
            .isEqualTo(405);

        // Validate the UserEntity in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    void deleteUserEntity() {
        // Initialize the database
        insertedUserEntity = userEntityRepository.save(userEntity).block();

        long databaseSizeBeforeDelete = getRepositoryCount();

        // Delete the userEntity
        webTestClient
            .delete()
            .uri(ENTITY_API_URL_ID, userEntity.getId())
            .accept(MediaType.APPLICATION_JSON)
            .exchange()
            .expectStatus()
            .isNoContent();

        // Validate the database contains one less item
        assertDecrementedRepositoryCount(databaseSizeBeforeDelete);
    }

    protected long getRepositoryCount() {
        return userEntityRepository.count().block();
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

    protected UserEntity getPersistedUserEntity(UserEntity userEntity) {
        return userEntityRepository.findById(userEntity.getId()).block();
    }

    protected void assertPersistedUserEntityToMatchAllProperties(UserEntity expectedUserEntity) {
        // Test fails because reactive api returns an empty object instead of null
        // assertUserEntityAllPropertiesEquals(expectedUserEntity, getPersistedUserEntity(expectedUserEntity));
        assertUserEntityUpdatableFieldsEquals(expectedUserEntity, getPersistedUserEntity(expectedUserEntity));
    }

    protected void assertPersistedUserEntityToMatchUpdatableProperties(UserEntity expectedUserEntity) {
        // Test fails because reactive api returns an empty object instead of null
        // assertUserEntityAllUpdatablePropertiesEquals(expectedUserEntity, getPersistedUserEntity(expectedUserEntity));
        assertUserEntityUpdatableFieldsEquals(expectedUserEntity, getPersistedUserEntity(expectedUserEntity));
    }
}
