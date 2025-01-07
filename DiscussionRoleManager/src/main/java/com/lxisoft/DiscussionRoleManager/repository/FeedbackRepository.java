package com.lxisoft.DiscussionRoleManager.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.lxisoft.DiscussionRoleManager.Feedback;

public interface FeedbackRepository extends JpaRepository<Feedback, Long> {
    List<Feedback> findBySessionId(int sessionId);
}
