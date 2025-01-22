package com.lxisoft.pomodoro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.lxisoft.pomodoro.entity.Pomodoro;
import com.lxisoft.pomodoro.service.PomodoroService;


@RestController
@RequestMapping("/api/pomodoro")
public class PomodoroController{

    @Autowired
    private PomodoroService service;

    @PostMapping("/set")
    public ResponseEntity<Pomodoro> setPomodoro(@RequestParam int workDuration, @RequestParam int breakDuration) {
        Pomodoro pomodoro = service.savePomodoro(workDuration, breakDuration);
        return ResponseEntity.ok(pomodoro);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Pomodoro> getPomodoro(@PathVariable Long id) {
        Pomodoro pomodoro = service.getPomodoroById(id);
        return ResponseEntity.ok(pomodoro);
    }
}