package com.lxisoft.emergencyalert.service.dto;

import jakarta.validation.constraints.*;
import java.io.Serializable;
import java.util.Objects;

/**
 * A DTO for the {@link com.lxisoft.emergencyalert.domain.GeoFence} entity.
 */
@SuppressWarnings("common-java:DuplicatedBlocks")
public class GeoFenceDTO implements Serializable {

    private Long id;

    @NotNull
    private String safeZones;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSafeZones() {
        return safeZones;
    }

    public void setSafeZones(String safeZones) {
        this.safeZones = safeZones;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof GeoFenceDTO)) {
            return false;
        }

        GeoFenceDTO geoFenceDTO = (GeoFenceDTO) o;
        if (this.id == null) {
            return false;
        }
        return Objects.equals(this.id, geoFenceDTO.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "GeoFenceDTO{" +
            "id=" + getId() +
            ", safeZones='" + getSafeZones() + "'" +
            "}";
    }
}
