package com.example.service;

import com.example.entity.DayPlan;
import com.example.repository.DayPlanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DayPlanService {

    @Autowired
    private DayPlanRepository dayPlanRepository;

    public DayPlan saveDayPlan(DayPlan dayPlan) {
        return dayPlanRepository.save(dayPlan);
    }

    public List<DayPlan> getAllDayPlans() {
        return dayPlanRepository.findAll();
    }

    public Optional<DayPlan> getDayPlanById(Long id) {
        return dayPlanRepository.findById(id);
    }

  

    public void deleteDayPlan(Long id) {
        dayPlanRepository.deleteById(id);
    }

    public Optional<DayPlan> updateDayPlan(Long id, DayPlan updatedDayPlan) {
        return dayPlanRepository.findById(id).map(existingDayPlan -> {
            existingDayPlan.setTitle(updatedDayPlan.getTitle());
            existingDayPlan.setDescription(updatedDayPlan.getDescription());
            existingDayPlan.setDate(updatedDayPlan.getDate());
            return dayPlanRepository.save(existingDayPlan);
        });
    }
}
