package com.demo.repository;

import com.demo.domain.Demo;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

/**
 * Spring Data R2DBC repository for the Demo entity.
 */
@SuppressWarnings("unused")
@Repository
public interface DemoRepository extends ReactiveCrudRepository<Demo, Long>, DemoRepositoryInternal {
    @Override
    <S extends Demo> Mono<S> save(S entity);

    @Override
    Flux<Demo> findAll();

    @Override
    Mono<Demo> findById(Long id);

    @Override
    Mono<Void> deleteById(Long id);
}

interface DemoRepositoryInternal {
    <S extends Demo> Mono<S> save(S entity);

    Flux<Demo> findAllBy(Pageable pageable);

    Flux<Demo> findAll();

    Mono<Demo> findById(Long id);
    // this is not supported at the moment because of https://github.com/jhipster/generator-jhipster/issues/18269
    // Flux<Demo> findAllBy(Pageable pageable, Criteria criteria);
}
