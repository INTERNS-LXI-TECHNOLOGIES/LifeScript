package com.diviso.habittrackbackend.domain;

import java.io.Serializable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

/**
 * A HabitTrack.
 */
@Table("habit_track")
@SuppressWarnings("common-java:DuplicatedBlocks")
public class HabitTrack implements Serializable {

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

    @Column("category")
    private String category;

    @Column("start_date")
    private String startDate;

    @Column("end_date")
    private String endDate;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public HabitTrack id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getHabitId() {
        return this.habitId;
    }

    public HabitTrack habitId(Integer habitId) {
        this.setHabitId(habitId);
        return this;
    }

    public void setHabitId(Integer habitId) {
        this.habitId = habitId;
    }

    public String getHabitName() {
        return this.habitName;
    }

    public HabitTrack habitName(String habitName) {
        this.setHabitName(habitName);
        return this;
    }

    public void setHabitName(String habitName) {
        this.habitName = habitName;
    }

    public String getDescription() {
        return this.description;
    }

    public HabitTrack description(String description) {
        this.setDescription(description);
        return this;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return this.category;
    }

    public HabitTrack category(String category) {
        this.setCategory(category);
        return this;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getStartDate() {
        return this.startDate;
    }

    public HabitTrack startDate(String startDate) {
        this.setStartDate(startDate);
        return this;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return this.endDate;
    }

    public HabitTrack endDate(String endDate) {
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
        if (!(o instanceof HabitTrack)) {
            return false;
        }
        return getId() != null && getId().equals(((HabitTrack) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "HabitTrack{" +
            "id=" + getId() +
            ", habitId=" + getHabitId() +
            ", habitName='" + getHabitName() + "'" +
            ", description='" + getDescription() + "'" +
            ", category='" + getCategory() + "'" +
            ", startDate='" + getStartDate() + "'" +
            ", endDate='" + getEndDate() + "'" +
            "}";
    }
}
