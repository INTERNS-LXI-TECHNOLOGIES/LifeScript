package com.diviso.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import java.io.Serializable;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A TwisterPractice.
 */
@Entity
@Table(name = "twister_practice")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class TwisterPractice implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "score")
    private Integer score;

    @Column(name = "times_practiced")
    private Integer timesPracticed;

    @Column(name = "corrections")
    private String corrections;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnoreProperties(value = { "twisterPractices" }, allowSetters = true)
    private MediaContent mediaContent;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public TwisterPractice id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getScore() {
        return this.score;
    }

    public TwisterPractice score(Integer score) {
        this.setScore(score);
        return this;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Integer getTimesPracticed() {
        return this.timesPracticed;
    }

    public TwisterPractice timesPracticed(Integer timesPracticed) {
        this.setTimesPracticed(timesPracticed);
        return this;
    }

    public void setTimesPracticed(Integer timesPracticed) {
        this.timesPracticed = timesPracticed;
    }

    public String getCorrections() {
        return this.corrections;
    }

    public TwisterPractice corrections(String corrections) {
        this.setCorrections(corrections);
        return this;
    }

    public void setCorrections(String corrections) {
        this.corrections = corrections;
    }

    public MediaContent getMediaContent() {
        return this.mediaContent;
    }

    public void setMediaContent(MediaContent mediaContent) {
        this.mediaContent = mediaContent;
    }

    public TwisterPractice mediaContent(MediaContent mediaContent) {
        this.setMediaContent(mediaContent);
        return this;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof TwisterPractice)) {
            return false;
        }
        return getId() != null && getId().equals(((TwisterPractice) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "TwisterPractice{" +
            "id=" + getId() +
            ", score=" + getScore() +
            ", timesPracticed=" + getTimesPracticed() +
            ", corrections='" + getCorrections() + "'" +
            "}";
    }
}
