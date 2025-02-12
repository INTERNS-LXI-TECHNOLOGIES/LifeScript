package com.lxisoft.emergencyalert.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.io.Serializable;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A BatteryStatus.
 */
@Entity
@Table(name = "battery_status")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class BatteryStatus implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @NotNull
    @Column(name = "battery_level", nullable = false)
    private Integer batteryLevel;

    @JsonIgnoreProperties(value = { "geoFence", "batteryStatus", "alerts", "teacher", "parent" }, allowSetters = true)
    @OneToOne(fetch = FetchType.LAZY, mappedBy = "batteryStatus")
    private Child child;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public BatteryStatus id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getBatteryLevel() {
        return this.batteryLevel;
    }

    public BatteryStatus batteryLevel(Integer batteryLevel) {
        this.setBatteryLevel(batteryLevel);
        return this;
    }

    public void setBatteryLevel(Integer batteryLevel) {
        this.batteryLevel = batteryLevel;
    }

    public Child getChild() {
        return this.child;
    }

    public void setChild(Child child) {
        if (this.child != null) {
            this.child.setBatteryStatus(null);
        }
        if (child != null) {
            child.setBatteryStatus(this);
        }
        this.child = child;
    }

    public BatteryStatus child(Child child) {
        this.setChild(child);
        return this;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof BatteryStatus)) {
            return false;
        }
        return getId() != null && getId().equals(((BatteryStatus) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "BatteryStatus{" +
            "id=" + getId() +
            ", batteryLevel=" + getBatteryLevel() +
            "}";
    }
}
