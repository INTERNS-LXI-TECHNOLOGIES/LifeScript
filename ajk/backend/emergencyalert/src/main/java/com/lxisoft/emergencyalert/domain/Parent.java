package com.lxisoft.emergencyalert.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A Parent.
 */
@Entity
@Table(name = "parent")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class Parent implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @NotNull
    @Column(name = "name", nullable = false)
    private String name;

    @NotNull
    @Column(name = "phone_number", nullable = false)
    private String phoneNumber;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "parent")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    @JsonIgnoreProperties(value = { "geoFence", "batteryStatus", "alerts", "teacher", "parent" }, allowSetters = true)
    private Set<Child> children = new HashSet<>();

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "parent")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    @JsonIgnoreProperties(value = { "parent" }, allowSetters = true)
    private Set<EmergencyContact> emergencyContacts = new HashSet<>();

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public Parent id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return this.name;
    }

    public Parent name(String name) {
        this.setName(name);
        return this;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return this.phoneNumber;
    }

    public Parent phoneNumber(String phoneNumber) {
        this.setPhoneNumber(phoneNumber);
        return this;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Set<Child> getChildren() {
        return this.children;
    }

    public void setChildren(Set<Child> children) {
        if (this.children != null) {
            this.children.forEach(i -> i.setParent(null));
        }
        if (children != null) {
            children.forEach(i -> i.setParent(this));
        }
        this.children = children;
    }

    public Parent children(Set<Child> children) {
        this.setChildren(children);
        return this;
    }

    public Parent addChildren(Child child) {
        this.children.add(child);
        child.setParent(this);
        return this;
    }

    public Parent removeChildren(Child child) {
        this.children.remove(child);
        child.setParent(null);
        return this;
    }

    public Set<EmergencyContact> getEmergencyContacts() {
        return this.emergencyContacts;
    }

    public void setEmergencyContacts(Set<EmergencyContact> emergencyContacts) {
        if (this.emergencyContacts != null) {
            this.emergencyContacts.forEach(i -> i.setParent(null));
        }
        if (emergencyContacts != null) {
            emergencyContacts.forEach(i -> i.setParent(this));
        }
        this.emergencyContacts = emergencyContacts;
    }

    public Parent emergencyContacts(Set<EmergencyContact> emergencyContacts) {
        this.setEmergencyContacts(emergencyContacts);
        return this;
    }

    public Parent addEmergencyContacts(EmergencyContact emergencyContact) {
        this.emergencyContacts.add(emergencyContact);
        emergencyContact.setParent(this);
        return this;
    }

    public Parent removeEmergencyContacts(EmergencyContact emergencyContact) {
        this.emergencyContacts.remove(emergencyContact);
        emergencyContact.setParent(null);
        return this;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Parent)) {
            return false;
        }
        return getId() != null && getId().equals(((Parent) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "Parent{" +
            "id=" + getId() +
            ", name='" + getName() + "'" +
            ", phoneNumber='" + getPhoneNumber() + "'" +
            "}";
    }
}
