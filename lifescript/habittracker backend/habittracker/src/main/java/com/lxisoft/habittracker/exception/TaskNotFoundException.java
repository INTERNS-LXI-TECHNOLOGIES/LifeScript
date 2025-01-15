package com.lxisoft.habittracker.exception;


public class TaskNotFoundException extends RuntimeException {
    private Long taskId;

    public TaskNotFoundException(Long taskId) {
        super("Task with ID " + taskId + " not found");
        this.taskId = taskId;
    }

    public Long getTaskId() {
        return taskId;
    }
}
