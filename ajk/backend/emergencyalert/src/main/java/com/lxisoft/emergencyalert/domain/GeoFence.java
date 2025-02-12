package com.lxisoft.emergencyalert.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.io.Serializable;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A GeoFence.
 */
@Entity
@Table(name = "geo_fence")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class GeoFence implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @NotNull
    @Column(name = "safe_zones", nullable = false)
    private String safeZones;

    @JsonIgnoreProperties(value = { "geoFence", "batteryStatus", "alerts", "teacher", "parent" }, allowSetters = true)
    @OneToOne(fetch = FetchType.LAZY, mappedBy = "geoFence")
    private Child child;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public GeoFence id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSafeZones() {
        return this.safeZones;
    }

    public GeoFence safeZones(String safeZones) {
        this.setSafeZones(safeZones);
        return this;
    }

    public void setSafeZones(String safeZones) {
        this.safeZones = safeZones;
    }

    public Child getChild() {
        return this.child;
    }

    public void setChild(Child child) {
        if (this.child != null) {
            this.child.setGeoFence(null);
        }
        if (child != null) {
            child.setGeoFence(this);
        }
        this.child = child;
    }

    public GeoFence child(Child child) {
        this.setChild(child);
        return this;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof GeoFence)) {
            return false;
        }
        return getId() != null && getId().equals(((GeoFence) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "GeoFence{" +
            "id=" + getId() +
            ", safeZones='" + getSafeZones() + "'" +
            "}";
    }
}
