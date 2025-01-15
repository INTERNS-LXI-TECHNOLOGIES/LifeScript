package com.lxisoft.habittracker.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.lxisoft.habittracker.entity.Task;

@Repository
public interface TaskRepository extends JpaRepository<Task , Long>{

}