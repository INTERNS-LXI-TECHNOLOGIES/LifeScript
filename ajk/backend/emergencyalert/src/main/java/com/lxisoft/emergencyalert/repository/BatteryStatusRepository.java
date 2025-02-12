package com.lxisoft.emergencyalert.repository;

import com.lxisoft.emergencyalert.domain.BatteryStatus;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the BatteryStatus entity.
 */
@SuppressWarnings("unused")
@Repository
public interface BatteryStatusRepository extends JpaRepository<BatteryStatus, Long> {}
