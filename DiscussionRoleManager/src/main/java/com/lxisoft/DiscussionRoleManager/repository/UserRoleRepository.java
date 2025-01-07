package com.lxisoft.DiscussionRoleManager.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.lxisoft.DiscussionRoleManager.UserRole;

public interface UserRoleRepository extends JpaRepository<UserRole, Long> {
    List<UserRole> findBySessionId(int sessionId);
}
