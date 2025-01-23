package com.diviso.Goalsetting.controller;

import com.diviso.Goalsetting.model.Goal;
import com.diviso.Goalsetting.service.GoalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/goals")
public class GoalController {

    @Autowired
    private GoalService goalService;

    @GetMapping
    public List<Goal> getAllGoals() {
        return goalService.getAllGoals();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Goal> getGoalById(@PathVariable Long id) {
        return goalService.getGoalById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Goal createGoal(@RequestBody Goal goal) {
        return goalService.saveGoal(goal);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Goal> updateGoal(@PathVariable Long id, @RequestBody Goal updatedGoal) {
        return goalService.getGoalById(id)
                .map(existingGoal -> {
                    existingGoal.setTitle(updatedGoal.getTitle());
                    existingGoal.setDescription(updatedGoal.getDescription());
                    existingGoal.setCompleted(updatedGoal.isCompleted());
                    goalService.saveGoal(existingGoal);
                    return ResponseEntity.ok(existingGoal);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteGoal(@PathVariable Long id) {
        if (goalService.getGoalById(id).isPresent()) {
            goalService.deleteGoal(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
