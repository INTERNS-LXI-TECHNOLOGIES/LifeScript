package com.example.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class DayPlan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title; // Title of the day plan
    private String description; // Description of the day plan
    private LocalDate date; // Date of the day plan

    // Default constructor
    public DayPlan() {}

    // Constructor with parameters
   

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    // Override toString method for better logging and debugging
    @Override
    public String toString() {
        return "DayPlan{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", date=" + date +
                '}';
    }
}
