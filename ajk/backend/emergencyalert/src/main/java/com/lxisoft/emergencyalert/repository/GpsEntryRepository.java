package com.lxisoft.emergencyalert.repository;

import com.lxisoft.emergencyalert.domain.GpsEntry;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the GpsEntry entity.
 */
@SuppressWarnings("unused")
@Repository
public interface GpsEntryRepository extends JpaRepository<GpsEntry, Long> {}
