package com.lxisoft.emergencyalert.service.dto;

import jakarta.validation.constraints.*;
import java.io.Serializable;
import java.util.Objects;

/**
 * A DTO for the {@link com.lxisoft.emergencyalert.domain.BatteryStatus} entity.
 */
@SuppressWarnings("common-java:DuplicatedBlocks")
public class BatteryStatusDTO implements Serializable {

    private Long id;

    @NotNull
    private Integer batteryLevel;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getBatteryLevel() {
        return batteryLevel;
    }

    public void setBatteryLevel(Integer batteryLevel) {
        this.batteryLevel = batteryLevel;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof BatteryStatusDTO)) {
            return false;
        }

        BatteryStatusDTO batteryStatusDTO = (BatteryStatusDTO) o;
        if (this.id == null) {
            return false;
        }
        return Objects.equals(this.id, batteryStatusDTO.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "BatteryStatusDTO{" +
            "id=" + getId() +
            ", batteryLevel=" + getBatteryLevel() +
            "}";
    }
}
