package com.example.repository;

import com.example.entity.DayPlan;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DayPlanRepository extends JpaRepository<DayPlan, Long> {
    // Custom queries can be added here if needed
}
