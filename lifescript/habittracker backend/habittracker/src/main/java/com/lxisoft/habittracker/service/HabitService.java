package com.lxisoft.habittracker.service;

 
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lxisoft.habittracker.entity.HabitEntity;
import com.lxisoft.habittracker.entity.Task;
import com.lxisoft.habittracker.repository.HabitRepository;
import com.lxisoft.habittracker.repository.TaskRepository;


@Service
public class HabitService{
    @Autowired
    private HabitRepository habitRepository;

    @Autowired
    private TaskRepository taskRepository;

    public HabitEntity createHabit(HabitEntity habit){
        return habitRepository.save(habit);
    }

    public List<HabitEntity> getAllHabits(){
        return habitRepository.findAll();
    }
    
    public List<Task> getTasksForHabit(Long habitId){
        return taskRepository.findAll().stream()
                             .filter(task->task.getHabit().getId().equals(habitId))
                             .collect(Collectors.toList());
    }

    public Task markTaskCompleted(Long taskId){
        Task task = taskRepository.findById(taskId).orElseThrow(() -> new RuntimeException("task not found"));
        task.setCompleted(true);
        return taskRepository.save(task);
    }
}