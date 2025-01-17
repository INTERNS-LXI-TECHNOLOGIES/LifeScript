package com.lxisoft.pomodoro.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.lxisoft.pomodoro.entity.Pomodoro;

@Repository
public interface PomodoroRepository extends JpaRepository<Pomodoro, Long>{
    
}