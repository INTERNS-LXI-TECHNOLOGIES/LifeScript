package com.lxisoft.emergencyalert.service.dto;

import jakarta.validation.constraints.*;
import java.io.Serializable;
import java.time.Instant;
import java.util.Objects;

/**
 * A DTO for the {@link com.lxisoft.emergencyalert.domain.GpsEntry} entity.
 */
@SuppressWarnings("common-java:DuplicatedBlocks")
public class GpsEntryDTO implements Serializable {

    private Long id;

    @NotNull
    private Double latitude;

    @NotNull
    private Double longitude;

    @NotNull
    private Instant timestamp;

    @NotNull
    private String deviceId;

    @NotNull
    private String status;

    private ChildDTO child;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Instant getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Instant timestamp) {
        this.timestamp = timestamp;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public ChildDTO getChild() {
        return child;
    }

    public void setChild(ChildDTO child) {
        this.child = child;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof GpsEntryDTO)) {
            return false;
        }

        GpsEntryDTO gpsEntryDTO = (GpsEntryDTO) o;
        if (this.id == null) {
            return false;
        }
        return Objects.equals(this.id, gpsEntryDTO.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "GpsEntryDTO{" +
            "id=" + getId() +
            ", latitude=" + getLatitude() +
            ", longitude=" + getLongitude() +
            ", timestamp='" + getTimestamp() + "'" +
            ", deviceId='" + getDeviceId() + "'" +
            ", status='" + getStatus() + "'" +
            ", child=" + getChild() +
            "}";
    }
}
