package com.diviso.repository;

import com.diviso.domain.MediaContent;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the MediaContent entity.
 */
@SuppressWarnings("unused")
@Repository
public interface MediaContentRepository extends JpaRepository<MediaContent, Long> {}
