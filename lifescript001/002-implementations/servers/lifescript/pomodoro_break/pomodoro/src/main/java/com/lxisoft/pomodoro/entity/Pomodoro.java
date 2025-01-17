package com.lxisoft.pomodoro.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Pomodoro {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int workDuration;
    private int breakDuration;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getWorkDuration() {
        return workDuration;
    }

    public void setWorkDuration(int workDuration) {
        this.workDuration = workDuration;
    }

    public int getBreakDuration() {
        return breakDuration;
    }

    public void setBreakDuration(int breakDuration) {
        this.breakDuration = breakDuration;
    }


}
