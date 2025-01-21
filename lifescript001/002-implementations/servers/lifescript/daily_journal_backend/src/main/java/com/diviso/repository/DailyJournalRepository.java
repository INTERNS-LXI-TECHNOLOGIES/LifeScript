package com.diviso.repository;

import com.diviso.domain.DailyJournal;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

/**
 * Spring Data R2DBC repository for the DailyJournal entity.
 */
@SuppressWarnings("unused")
@Repository
public interface DailyJournalRepository extends ReactiveCrudRepository<DailyJournal, Long>, DailyJournalRepositoryInternal {
    @Override
    <S extends DailyJournal> Mono<S> save(S entity);

    @Override
    Flux<DailyJournal> findAll();

    @Override
    Mono<DailyJournal> findById(Long id);

    @Override
    Mono<Void> deleteById(Long id);
}

interface DailyJournalRepositoryInternal {
    <S extends DailyJournal> Mono<S> save(S entity);

    Flux<DailyJournal> findAllBy(Pageable pageable);

    Flux<DailyJournal> findAll();

    Mono<DailyJournal> findById(Long id);
    // this is not supported at the moment because of https://github.com/jhipster/generator-jhipster/issues/18269
    // Flux<DailyJournal> findAllBy(Pageable pageable, Criteria criteria);
}
