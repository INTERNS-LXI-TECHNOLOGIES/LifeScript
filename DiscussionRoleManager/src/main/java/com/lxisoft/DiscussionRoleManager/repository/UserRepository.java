package com.lxisoft.DiscussionRoleManager.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.lxisoft.DiscussionRoleManager.User;

public interface UserRepository extends JpaRepository<User, Long> {
    
}
