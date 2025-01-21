package com.diviso.habittrackbackend.repository;

import com.diviso.habittrackbackend.domain.HabitTracker;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

/**
 * Spring Data R2DBC repository for the HabitTracker entity.
 */
@SuppressWarnings("unused")
@Repository
public interface HabitTrackerRepository extends ReactiveCrudRepository<HabitTracker, Long>, HabitTrackerRepositoryInternal {
    @Override
    <S extends HabitTracker> Mono<S> save(S entity);

    @Override
    Flux<HabitTracker> findAll();

    @Override
    Mono<HabitTracker> findById(Long id);

    @Override
    Mono<Void> deleteById(Long id);
}

interface HabitTrackerRepositoryInternal {
    <S extends HabitTracker> Mono<S> save(S entity);

    Flux<HabitTracker> findAllBy(Pageable pageable);

    Flux<HabitTracker> findAll();

    Mono<HabitTracker> findById(Long id);
    // this is not supported at the moment because of https://github.com/jhipster/generator-jhipster/issues/18269
    // Flux<HabitTracker> findAllBy(Pageable pageable, Criteria criteria);
}
