package com.diviso.habittracker.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.diviso.habittracker.entity.HabitEntity;

@Repository
public interface HabitRepository extends JpaRepository<HabitEntity , Long>{


    
}