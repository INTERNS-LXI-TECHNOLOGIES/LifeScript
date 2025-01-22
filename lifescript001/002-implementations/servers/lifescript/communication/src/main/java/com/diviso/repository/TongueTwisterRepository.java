package com.diviso.repository;

import com.diviso.domain.TongueTwister;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the TongueTwister entity.
 */
@SuppressWarnings("unused")
@Repository
public interface TongueTwisterRepository extends JpaRepository<TongueTwister, Long> {}
