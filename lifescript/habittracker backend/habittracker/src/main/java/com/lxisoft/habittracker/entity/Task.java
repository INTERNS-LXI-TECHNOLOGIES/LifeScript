package com.lxisoft.habittracker.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;

@Entity
public class Task {

    @Id
    private Long id;
    private boolean completed;

    @ManyToOne // Define the relationship between Task and HabitEntity
    private HabitEntity habit;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setCompleted(boolean completed) {
        this.completed = completed;
    }

    public boolean isCompleted() {
        return completed;
    }

    public void setHabit(HabitEntity habit) {
        this.habit = habit;
    }

    public HabitEntity getHabit() {
        return habit;
    }
}
