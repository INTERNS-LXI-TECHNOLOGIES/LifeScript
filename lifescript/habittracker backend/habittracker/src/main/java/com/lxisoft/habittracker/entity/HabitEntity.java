package com.lxisoft.habittracker.entity;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

@Entity
public class HabitEntity{

@Id
private Long id;
private String duration;
private String habit;
private String description;

@OneToMany(mappedBy = "habit") 
private List<Task> tasks = new ArrayList<>();

    public void setId(Long id) {
        this.id = id;
    }
    public Long getId() {
        return id;
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

    public String getDuration() {
        return duration;
    }
    public void setDuration(String duration) {
        this.duration = duration;
    }

}