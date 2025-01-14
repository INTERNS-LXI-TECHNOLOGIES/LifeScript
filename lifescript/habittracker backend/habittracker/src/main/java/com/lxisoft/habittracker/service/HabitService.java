package com.lxisoft.habittracker.service;

 
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.lxisoft.habittracker.entity.HabitEntity;
import com.lxisoft.habittracker.repository.HabitRepository;


@Service
public class HabitService{

    private HabitRepository habitRepository;

    public HabitEntity saveHabit(HabitEntity habit){
        return habitRepository.save(habit);
    }

    public List<HabitEntity> getAllHabits(){
        return habitRepository.findAll();
    }

    public Optional<HabitEntity> updateHabitById(Long id){
        return habitRepository.findById(id);
    }

    public void deleteHabit(Long id) {
        habitRepository.deleteById(id);
    }
    
}