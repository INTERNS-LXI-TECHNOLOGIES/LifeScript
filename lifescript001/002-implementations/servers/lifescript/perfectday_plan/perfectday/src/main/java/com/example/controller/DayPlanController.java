package com.example.controller;

import com.example.entity.DayPlan;
import com.example.service.DayPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/dayplans")
public class DayPlanController {

    @Autowired
    private DayPlanService dayPlanService;

    @PostMapping
    public DayPlan createDayPlan(@RequestBody DayPlan dayPlan) {
        return dayPlanService.saveDayPlan(dayPlan);
    }

    @GetMapping
    public List<DayPlan> getAllDayPlans() {
        return dayPlanService.getAllDayPlans();
    }

    @GetMapping("/{id}")
    public Optional<DayPlan> getDayPlanById(@PathVariable Long id) {
        return dayPlanService.getDayPlanById(id);
    }

  

    @PutMapping("/{id}")
    public DayPlan updateDayPlan(@PathVariable Long id, @RequestBody DayPlan dayPlan) {
        dayPlan.setId(id);
        return dayPlanService.saveDayPlan(dayPlan);
    }

    @DeleteMapping("/{id}")
    public void deleteDayPlan(@PathVariable Long id) {
        dayPlanService.deleteDayPlan(id);
    }
}
