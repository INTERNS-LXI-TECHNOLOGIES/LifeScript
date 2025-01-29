package com.diviso.habittrackbackend.repository;

import com.diviso.habittrackbackend.domain.UserEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

/**
 * Spring Data R2DBC repository for the UserEntity entity.
 */
@SuppressWarnings("unused")
@Repository
public interface UserEntityRepository extends ReactiveCrudRepository<UserEntity, Long>, UserEntityRepositoryInternal {
    @Override
    <S extends UserEntity> Mono<S> save(S entity);

    @Override
    Flux<UserEntity> findAll();

    @Override
    Mono<UserEntity> findById(Long id);

    @Override
    Mono<Void> deleteById(Long id);
}

interface UserEntityRepositoryInternal {
    <S extends UserEntity> Mono<S> save(S entity);

    Flux<UserEntity> findAllBy(Pageable pageable);

    Flux<UserEntity> findAll();

    Mono<UserEntity> findById(Long id);
    // this is not supported at the moment because of https://github.com/jhipster/generator-jhipster/issues/18269
    // Flux<UserEntity> findAllBy(Pageable pageable, Criteria criteria);
}
