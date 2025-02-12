package com.lxisoft.emergencyalert.repository;

import com.lxisoft.emergencyalert.domain.GeoFence;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the GeoFence entity.
 */
@SuppressWarnings("unused")
@Repository
public interface GeoFenceRepository extends JpaRepository<GeoFence, Long> {}
