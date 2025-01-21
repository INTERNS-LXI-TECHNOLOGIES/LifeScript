package com.diviso.repository;

import com.diviso.domain.TongueTwister;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the TongueTwister entity.
 */
@Repository
public interface TongueTwisterRepository extends JpaRepository<TongueTwister, Long> {
    @Query("select tongueTwister from TongueTwister tongueTwister where tongueTwister.creator.login = ?#{authentication.name}")
    List<TongueTwister> findByCreatorIsCurrentUser();

    default Optional<TongueTwister> findOneWithEagerRelationships(Long id) {
        return this.findOneWithToOneRelationships(id);
    }

    default List<TongueTwister> findAllWithEagerRelationships() {
        return this.findAllWithToOneRelationships();
    }

    default Page<TongueTwister> findAllWithEagerRelationships(Pageable pageable) {
        return this.findAllWithToOneRelationships(pageable);
    }

    @Query(
        value = "select tongueTwister from TongueTwister tongueTwister left join fetch tongueTwister.creator",
        countQuery = "select count(tongueTwister) from TongueTwister tongueTwister"
    )
    Page<TongueTwister> findAllWithToOneRelationships(Pageable pageable);

    @Query("select tongueTwister from TongueTwister tongueTwister left join fetch tongueTwister.creator")
    List<TongueTwister> findAllWithToOneRelationships();

    @Query("select tongueTwister from TongueTwister tongueTwister left join fetch tongueTwister.creator where tongueTwister.id =:id")
    Optional<TongueTwister> findOneWithToOneRelationships(@Param("id") Long id);
}
