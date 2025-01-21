package com.diviso.habittrackbackend.domain;

import java.io.Serializable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

/**
 * A HabitTracker.
 */
@Table("habit_tracker")
@SuppressWarnings("common-java:DuplicatedBlocks")
public class HabitTracker implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column("id")
    private Long id;

    @Column("habit_id")
    private Integer habitId;

    @Column("habit_name")
    private String habitName;

    @Column("description")
    private String description;

    @Column("start_date")
    private Integer startDate;

    @Column("end_date")
    private String endDate;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public HabitTracker id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getHabitId() {
        return this.habitId;
    }

    public HabitTracker habitId(Integer habitId) {
        this.setHabitId(habitId);
        return this;
    }

    public void setHabitId(Integer habitId) {
        this.habitId = habitId;
    }

    public String getHabitName() {
        return this.habitName;
    }

    public HabitTracker habitName(String habitName) {
        this.setHabitName(habitName);
        return this;
    }

    public void setHabitName(String habitName) {
        this.habitName = habitName;
    }

    public String getDescription() {
        return this.description;
    }

    public HabitTracker description(String description) {
        this.setDescription(description);
        return this;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getStartDate() {
        return this.startDate;
    }

    public HabitTracker startDate(Integer startDate) {
        this.setStartDate(startDate);
        return this;
    }

    public void setStartDate(Integer startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return this.endDate;
    }

    public HabitTracker endDate(String endDate) {
        this.setEndDate(endDate);
        return this;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof HabitTracker)) {
            return false;
        }
        return getId() != null && getId().equals(((HabitTracker) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "HabitTracker{" +
            "id=" + getId() +
            ", habitId=" + getHabitId() +
            ", habitName='" + getHabitName() + "'" +
            ", description='" + getDescription() + "'" +
            ", startDate=" + getStartDate() +
            ", endDate='" + getEndDate() + "'" +
            "}";
    }
}
