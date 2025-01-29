package com.diviso.domain;

import static com.diviso.domain.MediaContentTestSamples.*;
import static com.diviso.domain.TwisterPracticeTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.diviso.web.rest.TestUtil;
import java.util.HashSet;
import java.util.Set;
import org.junit.jupiter.api.Test;

class MediaContentTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(MediaContent.class);
        MediaContent mediaContent1 = getMediaContentSample1();
        MediaContent mediaContent2 = new MediaContent();
        assertThat(mediaContent1).isNotEqualTo(mediaContent2);

        mediaContent2.setId(mediaContent1.getId());
        assertThat(mediaContent1).isEqualTo(mediaContent2);

        mediaContent2 = getMediaContentSample2();
        assertThat(mediaContent1).isNotEqualTo(mediaContent2);
    }

    @Test
    void twisterPracticeTest() {
        MediaContent mediaContent = getMediaContentRandomSampleGenerator();
        TwisterPractice twisterPracticeBack = getTwisterPracticeRandomSampleGenerator();

        mediaContent.addTwisterPractice(twisterPracticeBack);
        assertThat(mediaContent.getTwisterPractices()).containsOnly(twisterPracticeBack);
        assertThat(twisterPracticeBack.getMediaContent()).isEqualTo(mediaContent);

        mediaContent.removeTwisterPractice(twisterPracticeBack);
        assertThat(mediaContent.getTwisterPractices()).doesNotContain(twisterPracticeBack);
        assertThat(twisterPracticeBack.getMediaContent()).isNull();

        mediaContent.twisterPractices(new HashSet<>(Set.of(twisterPracticeBack)));
        assertThat(mediaContent.getTwisterPractices()).containsOnly(twisterPracticeBack);
        assertThat(twisterPracticeBack.getMediaContent()).isEqualTo(mediaContent);

        mediaContent.setTwisterPractices(new HashSet<>());
        assertThat(mediaContent.getTwisterPractices()).doesNotContain(twisterPracticeBack);
        assertThat(twisterPracticeBack.getMediaContent()).isNull();
    }
}
