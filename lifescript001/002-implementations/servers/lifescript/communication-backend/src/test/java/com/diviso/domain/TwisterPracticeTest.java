package com.diviso.domain;

import static com.diviso.domain.MediaContentTestSamples.*;
import static com.diviso.domain.TwisterPracticeTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.diviso.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class TwisterPracticeTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(TwisterPractice.class);
        TwisterPractice twisterPractice1 = getTwisterPracticeSample1();
        TwisterPractice twisterPractice2 = new TwisterPractice();
        assertThat(twisterPractice1).isNotEqualTo(twisterPractice2);

        twisterPractice2.setId(twisterPractice1.getId());
        assertThat(twisterPractice1).isEqualTo(twisterPractice2);

        twisterPractice2 = getTwisterPracticeSample2();
        assertThat(twisterPractice1).isNotEqualTo(twisterPractice2);
    }

    @Test
    void mediaContentTest() {
        TwisterPractice twisterPractice = getTwisterPracticeRandomSampleGenerator();
        MediaContent mediaContentBack = getMediaContentRandomSampleGenerator();

        twisterPractice.setMediaContent(mediaContentBack);
        assertThat(twisterPractice.getMediaContent()).isEqualTo(mediaContentBack);

        twisterPractice.mediaContent(null);
        assertThat(twisterPractice.getMediaContent()).isNull();
    }
}
