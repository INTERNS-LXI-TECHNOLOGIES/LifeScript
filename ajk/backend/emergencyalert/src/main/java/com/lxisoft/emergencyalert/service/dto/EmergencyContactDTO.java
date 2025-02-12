package com.lxisoft.emergencyalert.service.dto;

import jakarta.validation.constraints.*;
import java.io.Serializable;
import java.util.Objects;

/**
 * A DTO for the {@link com.lxisoft.emergencyalert.domain.EmergencyContact} entity.
 */
@SuppressWarnings("common-java:DuplicatedBlocks")
public class EmergencyContactDTO implements Serializable {

    private Long id;

    @NotNull
    private String name;

    @NotNull
    private String type;

    @NotNull
    private String phoneNumber;

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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
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
        if (!(o instanceof EmergencyContactDTO)) {
            return false;
        }

        EmergencyContactDTO emergencyContactDTO = (EmergencyContactDTO) o;
        if (this.id == null) {
            return false;
        }
        return Objects.equals(this.id, emergencyContactDTO.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "EmergencyContactDTO{" +
            "id=" + getId() +
            ", name='" + getName() + "'" +
            ", type='" + getType() + "'" +
            ", phoneNumber='" + getPhoneNumber() + "'" +
            ", parent=" + getParent() +
            "}";
    }
}
