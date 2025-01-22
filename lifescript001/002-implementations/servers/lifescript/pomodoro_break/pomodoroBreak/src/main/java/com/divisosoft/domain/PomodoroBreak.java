package com.divisosoft.domain;

import java.io.Serializable;
import java.time.Instant;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

/**
 * A PomodoroBreak.
 */
@Table("pomodoro_break")
@SuppressWarnings("common-java:DuplicatedBlocks")
public class PomodoroBreak implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column("id")
    private Long id;

    @Column("user_name")
    private String userName;

    @Column("total_working_hour")
    private Integer totalWorkingHour;

    @Column("daily_duration_of_work")
    private Integer dailyDurationOfWork;

    @Column("split_break_duration")
    private Integer splitBreakDuration;

    @Column("break_duration")
    private Integer breakDuration;

    @Column("completed_breaks")
    private Integer completedBreaks;

    @Column("date_of_pomodoro")
    private Instant dateOfPomodoro;

    @Column("time_of_pomodoro_creation")
    private Instant timeOfPomodoroCreation;

    @Column("notification_for_break")
    private Boolean notificationForBreak;

    @Column("final_message")
    private String finalMessage;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public PomodoroBreak id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserName() {
        return this.userName;
    }

    public PomodoroBreak userName(String userName) {
        this.setUserName(userName);
        return this;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getTotalWorkingHour() {
        return this.totalWorkingHour;
    }

    public PomodoroBreak totalWorkingHour(Integer totalWorkingHour) {
        this.setTotalWorkingHour(totalWorkingHour);
        return this;
    }

    public void setTotalWorkingHour(Integer totalWorkingHour) {
        this.totalWorkingHour = totalWorkingHour;
    }

    public Integer getDailyDurationOfWork() {
        return this.dailyDurationOfWork;
    }

    public PomodoroBreak dailyDurationOfWork(Integer dailyDurationOfWork) {
        this.setDailyDurationOfWork(dailyDurationOfWork);
        return this;
    }

    public void setDailyDurationOfWork(Integer dailyDurationOfWork) {
        this.dailyDurationOfWork = dailyDurationOfWork;
    }

    public Integer getSplitBreakDuration() {
        return this.splitBreakDuration;
    }

    public PomodoroBreak splitBreakDuration(Integer splitBreakDuration) {
        this.setSplitBreakDuration(splitBreakDuration);
        return this;
    }

    public void setSplitBreakDuration(Integer splitBreakDuration) {
        this.splitBreakDuration = splitBreakDuration;
    }

    public Integer getBreakDuration() {
        return this.breakDuration;
    }

    public PomodoroBreak breakDuration(Integer breakDuration) {
        this.setBreakDuration(breakDuration);
        return this;
    }

    public void setBreakDuration(Integer breakDuration) {
        this.breakDuration = breakDuration;
    }

    public Integer getCompletedBreaks() {
        return this.completedBreaks;
    }

    public PomodoroBreak completedBreaks(Integer completedBreaks) {
        this.setCompletedBreaks(completedBreaks);
        return this;
    }

    public void setCompletedBreaks(Integer completedBreaks) {
        this.completedBreaks = completedBreaks;
    }

    public Instant getDateOfPomodoro() {
        return this.dateOfPomodoro;
    }

    public PomodoroBreak dateOfPomodoro(Instant dateOfPomodoro) {
        this.setDateOfPomodoro(dateOfPomodoro);
        return this;
    }

    public void setDateOfPomodoro(Instant dateOfPomodoro) {
        this.dateOfPomodoro = dateOfPomodoro;
    }

    public Instant getTimeOfPomodoroCreation() {
        return this.timeOfPomodoroCreation;
    }

    public PomodoroBreak timeOfPomodoroCreation(Instant timeOfPomodoroCreation) {
        this.setTimeOfPomodoroCreation(timeOfPomodoroCreation);
        return this;
    }

    public void setTimeOfPomodoroCreation(Instant timeOfPomodoroCreation) {
        this.timeOfPomodoroCreation = timeOfPomodoroCreation;
    }

    public Boolean getNotificationForBreak() {
        return this.notificationForBreak;
    }

    public PomodoroBreak notificationForBreak(Boolean notificationForBreak) {
        this.setNotificationForBreak(notificationForBreak);
        return this;
    }

    public void setNotificationForBreak(Boolean notificationForBreak) {
        this.notificationForBreak = notificationForBreak;
    }

    public String getFinalMessage() {
        return this.finalMessage;
    }

    public PomodoroBreak finalMessage(String finalMessage) {
        this.setFinalMessage(finalMessage);
        return this;
    }

    public void setFinalMessage(String finalMessage) {
        this.finalMessage = finalMessage;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof PomodoroBreak)) {
            return false;
        }
        return getId() != null && getId().equals(((PomodoroBreak) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "PomodoroBreak{" +
            "id=" + getId() +
            ", userName='" + getUserName() + "'" +
            ", totalWorkingHour=" + getTotalWorkingHour() +
            ", dailyDurationOfWork=" + getDailyDurationOfWork() +
            ", splitBreakDuration=" + getSplitBreakDuration() +
            ", breakDuration=" + getBreakDuration() +
            ", completedBreaks=" + getCompletedBreaks() +
            ", dateOfPomodoro='" + getDateOfPomodoro() + "'" +
            ", timeOfPomodoroCreation='" + getTimeOfPomodoroCreation() + "'" +
            ", notificationForBreak='" + getNotificationForBreak() + "'" +
            ", finalMessage='" + getFinalMessage() + "'" +
            "}";
    }
}
