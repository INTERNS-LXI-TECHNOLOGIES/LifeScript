package com.lxisoft.emergencyalert.service.dto;

import jakarta.validation.constraints.*;
import java.io.Serializable;
import java.util.Objects;

/**
 * A DTO for the {@link com.lxisoft.emergencyalert.domain.Child} entity.
 */
@SuppressWarnings("common-java:DuplicatedBlocks")
public class ChildDTO implements Serializable {

    private Long id;

    @NotNull
    private String name;

    @NotNull
    private Integer age;

    private String emergencyContact;

    private GeoFenceDTO geoFence;

    private BatteryStatusDTO batteryStatus;

    private TeacherDTO teacher;

    private ParentDTO parent;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getEmergencyContact() {
        return emergencyContact;
    }

    public void setEmergencyContact(String emergencyContact) {
        this.emergencyContact = emergencyContact;
    }

    public GeoFenceDTO getGeoFence() {
        return geoFence;
    }

    public void setGeoFence(GeoFenceDTO geoFence) {
        this.geoFence = geoFence;
    }

    public BatteryStatusDTO getBatteryStatus() {
        return batteryStatus;
    }

    public void setBatteryStatus(BatteryStatusDTO batteryStatus) {
        this.batteryStatus = batteryStatus;
    }

    public TeacherDTO getTeacher() {
        return teacher;
    }

    public void setTeacher(TeacherDTO teacher) {
        this.teacher = teacher;
    }

    public ParentDTO getParent() {
        return parent;
    }

    public void setParent(ParentDTO parent) {
        this.parent = parent;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof ChildDTO)) {
            return false;
        }

        ChildDTO childDTO = (ChildDTO) o;
        if (this.id == null) {
            return false;
        }
        return Objects.equals(this.id, childDTO.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "ChildDTO{" +
            "id=" + getId() +
            ", name='" + getName() + "'" +
            ", age=" + getAge() +
            ", emergencyContact='" + getEmergencyContact() + "'" +
            ", geoFence=" + getGeoFence() +
            ", batteryStatus=" + getBatteryStatus() +
            ", teacher=" + getTeacher() +
            ", parent=" + getParent() +
            "}";
    }
}
