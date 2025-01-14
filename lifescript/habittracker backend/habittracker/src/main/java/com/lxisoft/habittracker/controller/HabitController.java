package com.lxisoft.habittracker.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lxisoft.habittracker.entity.HabitEntity;
import com.lxisoft.habittracker.service.HabitService;

@RestController
@RequestMapping("/")
public class HabitController{

    private HabitService habitService;

    @PostMapping
    public  HabitEntity createHabit(@RequestBody HabitEntity habitEntity){
        return habitService.saveHabit(habitEntity);
    }

    @GetMapping
    public List<HabitEntity> getAllPersons() {
        return habitService.getAllHabits();
    }
 
}