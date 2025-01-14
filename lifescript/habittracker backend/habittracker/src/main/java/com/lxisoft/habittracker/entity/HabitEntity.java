package com.lxisoft.habittracker.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class HabitEntity{

@Id
private Long id;

private String name;
private String habit;
private String description;

    public void setId(Long id) {
        this.id = id;
    }
    public Long getId() {
        return id;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String getName() {
        return name;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    public String getDescription() {
        return description;
    }

    public String getHabit() {
        return habit;
    }
    public void setHabit(String habit) {
        this.habit = habit;
    }

}