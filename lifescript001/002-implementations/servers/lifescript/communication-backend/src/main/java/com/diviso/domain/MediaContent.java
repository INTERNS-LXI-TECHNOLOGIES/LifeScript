package com.diviso.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.io.Serializable;
import java.time.ZonedDateTime;
import java.util.HashSet;
import java.util.Set;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A MediaContent.
 */
@Entity
@Table(name = "media_content")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class MediaContent implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "text")
    private String text;

    @Lob
    @Column(name = "audio")
    private byte[] audio;

    @Column(name = "audio_content_type")
    private String audioContentType;

    @Column(name = "upload_date_time")
    private ZonedDateTime uploadDateTime;

    @NotNull
    @Column(name = "language", nullable = false)
    private String language;

    @NotNull
    @Column(name = "difficulty_level", nullable = false)
    private Integer difficultyLevel;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "mediaContent")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    @JsonIgnoreProperties(value = { "mediaContent" }, allowSetters = true)
    private Set<TwisterPractice> twisterPractices = new HashSet<>();

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public MediaContent id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getText() {
        return this.text;
    }

    public MediaContent text(String text) {
        this.setText(text);
        return this;
    }

    public void setText(String text) {
        this.text = text;
    }

    public byte[] getAudio() {
        return this.audio;
    }

    public MediaContent audio(byte[] audio) {
        this.setAudio(audio);
        return this;
    }

    public void setAudio(byte[] audio) {
        this.audio = audio;
    }

    public String getAudioContentType() {
        return this.audioContentType;
    }

    public MediaContent audioContentType(String audioContentType) {
        this.audioContentType = audioContentType;
        return this;
    }

    public void setAudioContentType(String audioContentType) {
        this.audioContentType = audioContentType;
    }

    public ZonedDateTime getUploadDateTime() {
        return this.uploadDateTime;
    }

    public MediaContent uploadDateTime(ZonedDateTime uploadDateTime) {
        this.setUploadDateTime(uploadDateTime);
        return this;
    }

    public void setUploadDateTime(ZonedDateTime uploadDateTime) {
        this.uploadDateTime = uploadDateTime;
    }

    public String getLanguage() {
        return this.language;
    }

    public MediaContent language(String language) {
        this.setLanguage(language);
        return this;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public Integer getDifficultyLevel() {
        return this.difficultyLevel;
    }

    public MediaContent difficultyLevel(Integer difficultyLevel) {
        this.setDifficultyLevel(difficultyLevel);
        return this;
    }

    public void setDifficultyLevel(Integer difficultyLevel) {
        this.difficultyLevel = difficultyLevel;
    }

    public Set<TwisterPractice> getTwisterPractices() {
        return this.twisterPractices;
    }

    public void setTwisterPractices(Set<TwisterPractice> twisterPractices) {
        if (this.twisterPractices != null) {
            this.twisterPractices.forEach(i -> i.setMediaContent(null));
        }
        if (twisterPractices != null) {
            twisterPractices.forEach(i -> i.setMediaContent(this));
        }
        this.twisterPractices = twisterPractices;
    }

    public MediaContent twisterPractices(Set<TwisterPractice> twisterPractices) {
        this.setTwisterPractices(twisterPractices);
        return this;
    }

    public MediaContent addTwisterPractice(TwisterPractice twisterPractice) {
        this.twisterPractices.add(twisterPractice);
        twisterPractice.setMediaContent(this);
        return this;
    }

    public MediaContent removeTwisterPractice(TwisterPractice twisterPractice) {
        this.twisterPractices.remove(twisterPractice);
        twisterPractice.setMediaContent(null);
        return this;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof MediaContent)) {
            return false;
        }
        return getId() != null && getId().equals(((MediaContent) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "MediaContent{" +
            "id=" + getId() +
            ", text='" + getText() + "'" +
            ", audio='" + getAudio() + "'" +
            ", audioContentType='" + getAudioContentType() + "'" +
            ", uploadDateTime='" + getUploadDateTime() + "'" +
            ", language='" + getLanguage() + "'" +
            ", difficultyLevel=" + getDifficultyLevel() +
            "}";
    }
}
