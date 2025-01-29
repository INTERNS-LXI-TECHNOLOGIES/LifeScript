package com.diviso.habittrackbackend.repository;

import com.diviso.habittrackbackend.domain.HabitTrack;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

/**
 * Spring Data R2DBC repository for the HabitTrack entity.
 */
@SuppressWarnings("unused")
@Repository
public interface HabitTrackRepository extends ReactiveCrudRepository<HabitTrack, Long>, HabitTrackRepositoryInternal {
    @Override
    <S extends HabitTrack> Mono<S> save(S entity);

    @Override
    Flux<HabitTrack> findAll();

    @Override
    Mono<HabitTrack> findById(Long id);

    @Override
    Mono<Void> deleteById(Long id);
}

interface HabitTrackRepositoryInternal {
    <S extends HabitTrack> Mono<S> save(S entity);

    Flux<HabitTrack> findAllBy(Pageable pageable);

    Flux<HabitTrack> findAll();

    Mono<HabitTrack> findById(Long id);
    // this is not supported at the moment because of https://github.com/jhipster/generator-jhipster/issues/18269
    // Flux<HabitTrack> findAllBy(Pageable pageable, Criteria criteria);
}
