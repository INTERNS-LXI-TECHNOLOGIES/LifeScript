package com.lxisoft.pomodoro.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lxisoft.pomodoro.entity.Pomodoro;
import com.lxisoft.pomodoro.repository.PomodoroRepository;

@Service
public class PomodoroService {
    
    @Autowired
    private PomodoroRepository repository;

    public Pomodoro savePomodoro(int workDuration, int breakDuration) {
        Pomodoro pomodoro = new Pomodoro();
        pomodoro.setWorkDuration(workDuration);
        pomodoro.setBreakDuration(breakDuration);
        return repository.save(pomodoro);
    }

    public Pomodoro getPomodoroById(Long id) {
        return repository.findById(id).orElse(null);
    }
}