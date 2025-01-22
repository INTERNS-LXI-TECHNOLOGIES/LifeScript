package com.diviso.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.io.Serializable;

/**
 * A TongueTwister.
 */
@Entity
@Table(name = "tongue_twister")
@SuppressWarnings("common-java:DuplicatedBlocks")
public class TongueTwister implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @NotNull
    @Column(name = "text", nullable = false)
    private String text;

    @NotNull
    @Column(name = "language", nullable = false)
    private String language;

    @Column(name = "difficulty_level")
    private Integer difficultyLevel;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public TongueTwister id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getText() {
        return this.text;
    }

    public TongueTwister text(String text) {
        this.setText(text);
        return this;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getLanguage() {
        return this.language;
    }

    public TongueTwister language(String language) {
        this.setLanguage(language);
        return this;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public Integer getDifficultyLevel() {
        return this.difficultyLevel;
    }

    public TongueTwister difficultyLevel(Integer difficultyLevel) {
        this.setDifficultyLevel(difficultyLevel);
        return this;
    }

    public void setDifficultyLevel(Integer difficultyLevel) {
        this.difficultyLevel = difficultyLevel;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof TongueTwister)) {
            return false;
        }
        return getId() != null && getId().equals(((TongueTwister) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "TongueTwister{" +
            "id=" + getId() +
            ", text='" + getText() + "'" +
            ", language='" + getLanguage() + "'" +
            ", difficultyLevel=" + getDifficultyLevel() +
            "}";
    }
}
