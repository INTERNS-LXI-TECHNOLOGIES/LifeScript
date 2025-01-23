package com.diviso.perfectday.repository;

import com.diviso.perfectday.domain.PerfectDay;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the PerfectDay entity.
 */
@SuppressWarnings("unused")
@Repository
public interface PerfectDayRepository extends JpaRepository<PerfectDay, Long> {}
