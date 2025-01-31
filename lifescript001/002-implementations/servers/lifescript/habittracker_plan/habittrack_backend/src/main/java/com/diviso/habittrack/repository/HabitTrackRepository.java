package com.diviso.habittrack.repository;

import com.diviso.habittrack.domain.HabitTrack;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the HabitTrack entity.
 */
@SuppressWarnings("unused")
@Repository
public interface HabitTrackRepository extends JpaRepository<HabitTrack, Long> {}
