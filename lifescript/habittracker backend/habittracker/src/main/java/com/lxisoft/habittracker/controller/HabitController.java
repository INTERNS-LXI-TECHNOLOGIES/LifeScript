package com.lxisoft.habittracker.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lxisoft.habittracker.entity.HabitEntity;
import com.lxisoft.habittracker.entity.Task;
import com.lxisoft.habittracker.exception.TaskNotFoundException;
import com.lxisoft.habittracker.repository.TaskRepository;
import com.lxisoft.habittracker.service.HabitService;

@RestController
@RequestMapping("/")
public class HabitController{
    
    @Autowired
    private HabitService habitService;
   
    @Autowired
    private TaskRepository taskRepository;

    @PostMapping
    public  HabitEntity saveHabit(@RequestBody HabitEntity habitEntity){
        return habitService.createHabit(habitEntity);
    }

    @GetMapping
    public List<HabitEntity> readAllHabits() {
        return habitService.getAllHabits();
    }

    @GetMapping("/read")
    public List<Task> getTaskForAllHabits(@PathVariable Long habitId){
        return habitService.getTasksForHabit(habitId);
    }

    @PostMapping("/delete")
    public List<Task> markTaskCompleted(Long taskId){
        Task task = taskRepository.findById(taskId).orElseThrow(() -> new TaskNotFoundException(taskId));
        task.setCompleted(true);
        taskRepository.save(task);
        return taskRepository.findAll();
    }
 
}